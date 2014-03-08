//
//  DBGroupService.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBGroupService.h"
#import "DBGroupRepository.h"
#import "DBAreaRepository.h"
#import "DBItemRepository.h"
#import "Group.h"
#import "NSString+Extensions.h"

@interface DBGroupService()

@property (nonatomic, assign) id<DBGroupRepository> groupRepository;
@property (nonatomic, assign) id<DBAreaRepository> areaRepository;
@property (nonatomic, assign) id<DBItemRepository> itemRepository;

@end

@implementation DBGroupService

- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository
				areaRepository: (id<DBAreaRepository>) areaRepository
				itemRepository: (id<DBItemRepository>) itemRepository
{
    self = [super init];
    if (self)
	{
        self.groupRepository = groupRepository;
		self.areaRepository = areaRepository;
		self.itemRepository = itemRepository;
    }
    return self;
}

- (Group *) createBlankGroup
{
	Group *group = [self.groupRepository createEntity];
	group.syncId = [NSString uuid];
	group.syncStatus = @(DBSyncStatusCreated);
	return group;
}

- (void) deleteGroup: (Group *) group hard: (BOOL) isHardDelete
{
	if (isHardDelete || [group.syncStatus isEqual: @(DBSyncStatusCreated)])
	{
		[self.groupRepository deleteEntity: group];
		return;
	}
	group.syncStatus = @(DBSyncStatusDeleted);
}

- (void) addArea: (Area *) area toGroup: (Group *) group
{
	[self.groupRepository insertObject: area atKey: @"areas" onEntity: group];
	[self.areaRepository addObject: group forKey: @"group" onEntity: area];
}

- (void) addItem: (Item *) item toGroup: (Group *) group
{
	[self.groupRepository insertObject: item atKey: @"items" onEntity: group];
	[self.itemRepository addObject: group forKey: @"group" onEntity: item];
}

- (void) saveGroup: (Group *) group toPush: (BOOL) toPush withCompletion: (void (^)(BOOL success, NSError *error)) completion
{
	if (toPush && ![group.syncStatus isEqual: @(DBSyncStatusCreated)] && ![group.syncStatus isEqual: @(DBSyncStatusDeleted)])
	{
		group.syncStatus = @(DBSyncStatusEdited);
	}
	
	[self.groupRepository save: group withCompletion: completion];
}

- (NSArray *) getAll
{
	NSPredicate *filter = [NSPredicate predicateWithFormat: @"syncStatus != %@", @(DBSyncStatusDeleted)];
	return [[self.groupRepository getAll] filteredArrayUsingPredicate: filter];
}

- (NSArray *) getAllCreated
{
	return [self.groupRepository getAllByAttribute: @"syncStatus" value: @(DBSyncStatusCreated)];
}

- (NSArray *) getAllEdited
{
	return [self.groupRepository getAllByAttribute: @"syncStatus" value: @(DBSyncStatusEdited)];
}

- (NSArray *) getAllDeleted
{
	return [self.groupRepository getAllByAttribute: @"syncStatus" value: @(DBSyncStatusDeleted)];
}

@end
