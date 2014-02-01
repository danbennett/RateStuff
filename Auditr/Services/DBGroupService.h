//
//  DBGroupService.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;
@protocol DBGroupRepository;

@protocol DBGroupService <NSObject>

@required
- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllActive;

@end

@interface DBGroupService : NSObject

- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllActive;

@end
