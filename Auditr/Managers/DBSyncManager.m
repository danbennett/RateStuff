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
#import "DBGroupSyncManager.h"
#import "Profile.h"

@interface DBSyncManager()

//@property (nonatomic, assign) id<DBParseService> parseService;
//@property (nonatomic, assign) id<DBProfileService> profileService;
@property (nonatomic, assign) id<DBGroupSyncManager> groupSync;

@end

@implementation DBSyncManager

- (id) initWithGroupSyncManager: (id<DBGroupSyncManager>) groupSyncManager
{
    self = [super init];
    if (self)
	{
//        self.parseService = parseService;
//		self.profileService = profileService;
		self.groupSync = groupSyncManager;
    }
    return self;
}

- (RACSignal *) syncPush
{
	return [self.groupSync push];
}

@end
