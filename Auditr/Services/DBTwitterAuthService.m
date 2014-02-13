//
//  DBTwitterAuthService.m
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterAuthService.h"
#import "DBTwitterServiceClient.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface DBTwitterAuthService()

@property (nonatomic, strong, readwrite) ACAccount *currentUser;
@property (nonatomic, assign) id<DBTwitterServiceClient> serviceClient;
@property (nonatomic, strong) ACAccountStore *accountStore;

@end

static NSString *const DBUserDefaultTwitterAccountKey = @"twitterAccountId";

@implementation DBTwitterAuthService

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
{
    self = [super init];
    if (self)
	{
		self.serviceClient = serviceClient;
		self.accountStore = [[ACAccountStore alloc] init];
		
		[self collectUser];
    }
    return self;
}

- (void) collectUser
{
	NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey: DBUserDefaultTwitterAccountKey];
	if (userId)
	{
		self.currentUser = [self.accountStore accountWithIdentifier: userId];
	}
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
					self.currentUser = accountTypes[0];
					[subject sendNext: self.currentUser];
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

- (void) saveUser: (ACAccount *) user
{
	[[NSUserDefaults standardUserDefaults] setValue: user.identifier forKey: DBUserDefaultTwitterAccountKey];
}

- (RACSignal *) loadProfileImageForUser: (ACAccount *) user
{
	return [self.serviceClient loadProfileForUser: user];
}

@end
