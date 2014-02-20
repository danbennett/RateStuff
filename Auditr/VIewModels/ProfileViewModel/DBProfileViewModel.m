//
//  DBProfileViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 13/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "DBProfileViewModel.h"
#import "DBProfileService.h"
#import "DBParseService.h"
#import "Profile.h"

@interface DBProfileViewModel()

@property (nonatomic, strong, readwrite) NSString *profileName;
@property (nonatomic, strong, readwrite) UIImage *profileImage;
@property (nonatomic, strong, readwrite) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readwrite) RACCommand *loginWithAccountCommand;
@property (nonatomic, assign) id<DBProfileService> profileService;
@property (nonatomic, assign) id<DBParseService> parseService;

@end

@implementation DBProfileViewModel

- (id) initWithProfileService: (id<DBProfileService>) profileService
				 parseService: (id<DBParseService>) parseService
{
    self = [super init];
    if (self)
	{
        self.profileService = profileService;
		self.parseService = parseService;
		
		[self createBindings];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	@weakify(self);
	[[RACObserve(self, profile) distinctUntilChanged] subscribeNext:^(Profile *profile) {
		
		@strongify(self);
		self.profileName = profile.profileName;
		[self loadImageWithData: profile.profileImage];
		
		[self applyBindings];
	}];
	
	self.chooseTwitterAccountCommand =
	[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self.profileService loadTwitterAccounts];
	}];
	
	self.loginWithAccountCommand =
	[[RACCommand alloc] initWithSignalBlock:^RACSignal *(ACAccount *account) {
		@strongify(self);
		self.profile = [self.profileService loginWithAccount: account];
		return [self signInAndSync: self.profile];
	}];
}

- (void) applyBindings
{
	@weakify(self);
	[RACObserve(self, profileImage) subscribeNext:^(UIImage *image) {
		
		if (image != nil)
		{
			__block NSData *data = nil;
			
			dispatch_queue_t imageQueue = dispatch_queue_create("uk.co.bennettdan.imageArchiver", NULL);
			
			dispatch_async(imageQueue, ^{
				
				data = [NSKeyedArchiver archivedDataWithRootObject: image];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					self.profile.profileImage = data;
				});
			});
		}
		
	}];
}

#pragma mark - Logon & download.

- (RACSignal *) signInAndSync: (Profile *) profile
{
	@weakify(self);
	return [[[self.profileService loadProfileImageForProfile: profile] flattenMap:^RACStream *(UIImage *image) {
		
		@strongify(self);
		self.profileImage = image;
		return [self.profileService reverseOAuthForProfile: self.profile];
		
	}] flattenMap:^RACStream *(NSDictionary *details) {
		
		@strongify(self);
		NSString *userId = details[DBTwitterResponseUserIdKey];
		NSString *screenName = details[DBTwitterResponseScreenNameKey];
		NSString *oAuthToken = details[DBTwitterResponseOAuthTokenKey];
		NSString *oAuthTokenSecret = details[DBTwitterResponseOAuthTokenSecretKey];
		
		return [self.parseService loginWithId: userId screenName: screenName authToken: oAuthToken authTokenSecret: oAuthTokenSecret];
	}];
}

- (void) deleteProfile
{
	[self.profileService deleteProfile: self.profile];
}

- (void) activateProfile
{
	[self.profileService activateProfile: self.profile];
}

- (void) loadImageWithData: (NSData *) data
{
	@weakify(self);
	
	if (data != nil)
	{
		dispatch_queue_t imageQueue = dispatch_queue_create("uk.co.bennettdan.imageUnarchiver", NULL);
		dispatch_async(imageQueue, ^{
			
			@strongify(self);
			
			UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData: data];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				@strongify(self);
				self.profileImage = image;
			});
		});
	}
}

@end
