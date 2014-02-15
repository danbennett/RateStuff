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
#import <Parse-iOS-SDK/Parse.h>

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

- (RACSignal *) linkCurrentUserWithId: (NSString *) twitterId
						   screenName: (NSString *) screenName
							authToken: (NSString *) authToken
					  authTokenSecret: (NSString *) authTokenSecret
{
	PFUser *currentUser = [PFUser currentUser];
	return [self.serviceClient linkUser: currentUser
								 withId: twitterId
							 screenName: screenName
							  authToken: authToken
						authTokenSecret: authTokenSecret];
}

- (RACSignal *) listAllUsers
{
	return [self.serviceClient syncAllUsers];
}

- (RACSignal *) syncAllObjectsForUser: (NSString *) username
{
	return [self syncGroupsForUser: username];
}

- (RACSignal *) syncGroupsForUser: (NSString *) username
{
	return [self.serviceClient syncClassesOfName: @"group" updatedAfterDate: [self dateForGroup] forUser: username];
}

- (NSDate *) dateForGroup
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"lastUpdated" ascending: NO];
	NSArray *latestGroup = [[self.groupRepository getAll] sortedArrayUsingDescriptors: @[sortDescriptor]];
	Group *group = [[latestGroup objectEnumerator] firstOrDefault];
	return group.lastUpdated;
}

@end
