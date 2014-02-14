//
//  DBParseService.m
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBParseService.h"
#import "DBParseServiceClient.h"
#import "DBGroupRepository.h"
#import "Group.h"

@interface DBParseService()

@property (nonatomic, assign) id<DBParseServiceClient> serviceClient;
@property (nonatomic, assign) id<DBGroupRepository> groupRepository;

@end

@implementation DBParseService

- (id) initWithServiceClient: (id<DBParseServiceClient>) serviceClient
			 groupRepository: (id<DBGroupRepository>) groupRepository
{
    self = [super init];
    if (self)
	{
        self.serviceClient = serviceClient;
		self.groupRepository = groupRepository;
    }
    return self;
}

- (RACSignal *) syncAllObjectsForUser: (NSString *) username
{
	return [self syncGroupsForUser: username];
}

- (RACSignal *) syncGroupsForUser: (NSString *) username
{
	return [self.serviceClient syncClassesOfName: @"Group" updatedAfterDate: [self dateForGroup] forUser: username];
}

- (NSDate *) dateForGroup
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"lastUpdated" ascending: NO];
	NSArray *latestGroup = [[self.groupRepository getAll] sortedArrayUsingDescriptors: @[sortDescriptor]];
	Group *group = [[latestGroup objectEnumerator] firstOrDefault];
	return group.lastUpdated;
}

@end
