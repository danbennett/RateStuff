//
//  DBSettingsViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsViewModel.h"
#import "DBTwitterAuthService.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>

@interface DBSettingsViewModel()

@property (nonatomic, strong, readwrite) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readwrite) NSString *twitterUsername;
@property (nonatomic, assign) id<DBTwitterAuthService> twitterAuthService;

@end

@implementation DBSettingsViewModel

- (id) initWithTwitterAuthService: (id<DBTwitterAuthService>) twitterAuthService
{
    self = [super init];
    if (self)
	{
		self.twitterAuthService = twitterAuthService;
		
		[self createBindings];
		[self loadTwitterUsername];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	@weakify(self);
	self.chooseTwitterAccountCommand =
	[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self twitterUserSignals];
	}];
}

- (RACSignal *) twitterUserSignals
{
	@weakify(self);
	return [[self.twitterAuthService login] flattenMap:^RACStream *(ACAccount *user) {
		@strongify(self);
		self.twitterUsername = [self.twitterAuthService currentUser].username;
		return [self.twitterAuthService loadProfileImageForUser: user];
	}];
}

- (void) loadTwitterUsername
{
	self.twitterUsername = [self.twitterAuthService currentUser].username;
}

@end
