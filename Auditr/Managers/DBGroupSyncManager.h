//
//  DBGroupSyncManager.h
//  Auditr
//
//  Created by Daniel Bennett on 03/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBGroupService;
@protocol DBParseServiceClient;
@protocol DBProfileService;

@protocol DBGroupSyncManager <NSObject>

- (id) initWithGroupService: (id<DBGroupService>) groupService
		 parseServiceClient: (id<DBParseServiceClient>) serviceClient
			 profileService: (id<DBProfileService>) profileService;

- (RACSignal *) push;

@end

@interface DBGroupSyncManager : NSObject <DBGroupSyncManager>

- (id) initWithGroupService: (id<DBGroupService>) groupService
		 parseServiceClient: (id<DBParseServiceClient>) serviceClient
			 profileService: (id<DBProfileService>) profileService;

- (RACSignal *) push;

@end
