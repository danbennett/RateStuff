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
@class Item;
@protocol DBGroupRepository;
@protocol DBAreaRepository;
@protocol DBItemRepository;

@protocol DBGroupService <NSObject>

@required
- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository
				areaRepository: (id<DBAreaRepository>) areaRepository
				itemRepository: (id<DBItemRepository>) itemRepository;

- (void) addItem: (Item *) item toGroup: (Group *) group;
- (void) addArea: (Area *) area toGroup: (Group *) group;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllCreated;
- (NSArray *) getAllEdited;
- (NSArray *) getAllDeleted;
- (void) saveGroup: (Group *) group toPush: (BOOL) toPush withCompletion: (void (^)(BOOL success, NSError *error)) completion;
- (void) deleteGroup: (Group *) group hard: (BOOL) isHardDelete;

@end

@interface DBGroupService : NSObject

- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository
				areaRepository: (id<DBAreaRepository>) areaRepository
				itemRepository: (id<DBItemRepository>) itemRepository;

- (void) addItem: (Item *) item toGroup: (Group *) group;
- (void) addArea: (Area *) area toGroup: (Group *) group;
- (Group *) createBlankGroup;
- (NSArray *) getAll;
- (NSArray *) getAllCreated;
- (NSArray *) getAllEdited;
- (NSArray *) getAllDeleted;
- (void) saveGroup: (Group *) group toPush: (BOOL) toPush withCompletion: (void (^)(BOOL success, NSError *error)) completion;
- (void) deleteGroup: (Group *) group hard: (BOOL) isHardDelete;

@end
