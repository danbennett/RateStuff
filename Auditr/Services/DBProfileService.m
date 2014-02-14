//
//  DBTwitterAuthService.m
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBProfileService.h"
#import "DBTwitterServiceClient.h"
#import	"DBProfileRepository.h"
#import "Profile.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface DBProfileService()

@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, assign) id<DBTwitterServiceClient> serviceClient;
@property (nonatomic, assign) id<DBProfileRepository> repository;


@end

static NSString *const DBUserDefaultTwitterAccountKey = @"twitterAccountId";

@implementation DBProfileService

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		   profileRepository: (id<DBProfileRepository>) repository
{
    self = [super init];
    if (self)
	{
		self.serviceClient = serviceClient;
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
					[subject sendNext: account];
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

- (void) saveProfile: (Profile *) profile
{
	
}

- (RACSignal *) loadProfileImageForProfile: (Profile *) profile
{
	ACAccount *account = [self.accountStore accountWithIdentifier: profile.profileId];
	if (account)
	{
		return [self.serviceClient loadProfileForUser: account];
	}
	return nil;
}

@end
