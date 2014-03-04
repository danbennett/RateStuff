//
//  DBSyncManager.h
//  Auditr
//
//  Created by Daniel Bennett on 23/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBParseService;
@protocol DBProfileService;
@protocol DBGroupService;
@protocol DBGroupSyncManager;

@interface DBSyncManager : NSObject

- (id) initWithGroupSyncManager: (id<DBGroupSyncManager>) groupSyncManager;

- (RACSignal *) syncPush;

@end
