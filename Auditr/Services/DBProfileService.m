//
//  DBTwitterAuthService.m
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBProfileService.h"
#import "DBTwitterServiceClient.h"
#import "DBTwitterOAuthServiceClient.h"
#import	"DBProfileRepository.h"
#import "Profile.h"
#import <Parse-iOS-SDK/Parse.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface DBProfileService()

@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, assign) id<DBTwitterServiceClient> serviceClient;
@property (nonatomic, assign) id<DBTwitterOAuthServiceClient> oAuthServiceClient;
@property (nonatomic, assign) id<DBProfileRepository> repository;


@end

NSString const *DBUserDefaultTwitterAccountKey = @"twitterAccountId";
NSString const *DBTwitterResponseUserIdKey = @"user_id";
NSString const *DBTwitterResponseScreenNameKey = @"screen_name";
NSString const *DBTwitterResponseOAuthTokenSecretKey = @"oauth_token_secret";
NSString const *DBTwitterResponseOAuthTokenKey = @"oauth_token";

@implementation DBProfileService

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		  oAuthServiceClient: (id<DBTwitterOAuthServiceClient>) oAuthServiceClient
		   profileRepository: (id<DBProfileRepository>) repository
{
    self = [super init];
    if (self)
	{
		self.serviceClient = serviceClient;
		self.oAuthServiceClient = oAuthServiceClient;
		self.repository = repository;
		self.accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (Profile *) currentProfile
{
	Profile *profile = [[[self.repository getAll] objectEnumerator] firstOrDefault];
	if (profile)
	{
		ACAccount *account = [self.accountStore accountWithIdentifier: profile.profileId];
		if (!account)
		{
			[self.repository deleteEntity: profile];
		}
	}
	return profile;
}

- (Profile *) createProfile
{
	return [self.repository createEntity];
}

- (RACSignal *) login
{
	@weakify(self);
	RACSubject *subject = [RACSubject subject];
	
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
	[self.accountStore requestAccessToAccountsWithType: accountType options: nil completion:^(BOOL granted, NSError *error) {
		
		if (granted)
		{
			dispatch_async(dispatch_get_main_queue(), ^{
				@strongify(self);
				NSArray *accountTypes = [self.accountStore accountsWithAccountType: accountType];
				if (accountTypes.count > 0)
				{
					ACAccount *account = accountTypes[0];
					Profile *profile = [self.repository createEntity];
					profile.profileId = account.identifier;
					profile.profileName = account.username;
					
					[subject sendNext: profile];
					[subject sendCompleted];
				}
				else
				{
					NSError *error = [NSError errorWithDomain: @"uk.co.danbennett" code: 401 userInfo: @{@"Description":  @"No users found"}];
					[subject sendError: error];
				}
			});
		}
	}];
	return subject;
}

- (RACSignal *) reverseOAuthForProfile: (Profile *) profile
{
	ACAccount *account = [self accountForProfile: profile];
	return [self.oAuthServiceClient reverseOAuthForAccount: account];
}

- (RACSignal *) loadProfileImageForProfile: (Profile *) profile
{
	ACAccount *account = [self accountForProfile: profile];
	if (account)
	{
		return [self.serviceClient loadProfileImageForUser: account];
	}
	return nil;
}

- (ACAccount *) accountForProfile: (Profile *) profile
{
	ACAccount *account = [self.accountStore accountWithIdentifier: profile.profileId];
	if (account)
	{
		return account;
	}
	return nil;
}

@end
