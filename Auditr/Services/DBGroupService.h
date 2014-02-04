//
//  DBGroupService.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;
@class Area;
@protocol DBGroupRepository;
@protocol DBAreaRepository;

@protocol DBGroupService <NSObject>

@required
- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository
				areaRepository: (id<DBAreaRepository>) areaRepository;
- (void) addArea: (Area *) area toGroup: (Group *) group;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllActive;
- (void) saveGroup: (Group *) group toPush: (BOOL) toPush withCompletion: (void (^)(BOOL success, NSError *error)) completion;
- (void) deleteGroup: (Group *) group;

@end

@interface DBGroupService : NSObject

- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository
				areaRepository: (id<DBAreaRepository>) areaRepository;
- (void) addArea: (Area *) area toGroup: (Group *) group;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllActive;
- (void) saveGroup: (Group *) group toPush: (BOOL) toPush withCompletion: (void (^)(BOOL success, NSError *error)) completion;
- (void) deleteGroup: (Group *) group;

@end
