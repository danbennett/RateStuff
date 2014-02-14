//
//  DBParseService.h
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBParseServiceClient;
@protocol DBGroupRepository;

@protocol DBParseService <NSObject>

- (id) initWithServiceClient: (id<DBParseServiceClient>) serviceClient
			 groupRepository: (id<DBGroupRepository>) groupRepository;
- (RACSignal *) syncAllObjectsForUser: (NSString *) username;

@end

@interface DBParseService : NSObject

- (id) initWithServiceClient: (id<DBParseServiceClient>) serviceClient
			 groupRepository: (id<DBGroupRepository>) groupRepository;
- (RACSignal *) syncAllObjectsForUser: (NSString *) username;

@end
