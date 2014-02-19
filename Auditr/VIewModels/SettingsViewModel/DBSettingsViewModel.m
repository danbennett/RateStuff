//
//  DBSettingsViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsViewModel.h"
#import "DBProfileService.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>

@interface DBSettingsViewModel()

@property (nonatomic, strong, readwrite) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readwrite) NSString *twitterUsername;
@property (nonatomic, assign) id<DBProfileService> profileService;

@end

@implementation DBSettingsViewModel

- (id) initWithTwitterAuthService: (id<DBProfileService>) profileService
{
    self = [super init];
    if (self)
	{
		self.profileService = profileService;
		
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
//	@weakify(self);
//	return [[self.profileService login] flattenMap:^RACStream *(ACAccount *user) {
//		@strongify(self);
//		return [self.twitterAuthService loadProfileImageForUser: user];
//	}];
	return nil;
}

- (void) loadTwitterUsername
{
//	self.twitterUsername = [self.twitterAuthService currentUser].username;
}

@end
