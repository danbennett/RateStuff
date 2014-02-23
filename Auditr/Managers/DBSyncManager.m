//
//  DBSyncManager.m
//  Auditr
//
//  Created by Daniel Bennett on 23/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSyncManager.h"
#import "DBParseService.h"
#import "DBProfileService.h"
#import "Profile.h"

@interface DBSyncManager()

@property (nonatomic, assign) id<DBParseService> parseService;
@property (nonatomic, assign) id<DBProfileService> profileService;

@end

@implementation DBSyncManager

- (id) initWithParseService: (id<DBParseService>) parseService
			 profileService: (id<DBProfileService>) profileService
{
    self = [super init];
    if (self)
	{
        self.parseService = parseService;
		self.profileService = profileService;
    }
    return self;
}

- (RACSignal *) syncPush
{
	NSString *userId = [self.profileService currentProfile].parseUserId;
	return [self.parseService pushAllObjectsForUser: userId];
}

@end
