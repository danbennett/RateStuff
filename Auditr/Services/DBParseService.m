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
#import "DBProfileRepository.h"
#import "SyncEntity.h"
#import "Group.h"
#import <Parse-iOS-SDK/Parse.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBParseService()

@property (nonatomic, assign) id<DBParseServiceClient> serviceClient;
@property (nonatomic, assign) id<DBGroupRepository> groupRepository;
@property (nonatomic, assign) id<DBProfileRepository> profileRepository;

@end

@implementation DBParseService

- (id) initWithServiceClient: (id<DBParseServiceClient>) serviceClient
		   profileRepository: (id<DBProfileRepository>) profileRepository
			 groupRepository: (id<DBGroupRepository>) groupRepository
{
    self = [super init];
    if (self)
	{
        self.serviceClient = serviceClient;
		self.groupRepository = groupRepository;
		self.profileRepository = profileRepository;
    }
    return self;
}

- (RACSignal *) loginWithId: (NSString *) twitterId
				 screenName: (NSString *) screenName
				  authToken: (NSString *) authToken
			authTokenSecret: (NSString *) authTokenSecret
{
	return [self.serviceClient linkWithId: twitterId
							   screenName: screenName
								authToken: authToken
						  authTokenSecret: authTokenSecret];
}

- (RACSignal *) listAllUsers
{
	return [self.serviceClient syncAllUsers];
}

- (RACSignal *) syncAllObjectsForUser: (NSString *) userId
{
	return [self syncGroupsForUser: userId];
}

- (RACSignal *) syncGroupsForUser: (NSString *) username
{
	return [self.serviceClient syncClassesOfName: @"Group" updatedAfterDate: [self dateForGroup] forUser: username];
}

- (RACSignal *) pushAllObjectsForUser: (NSString *) userId
{
	Profile *profile = [[[self.profileRepository getAllByAttribute: @"parseUserId" value: userId] objectEnumerator] firstOrDefault];
	
	NSPredicate *profilePredicate = [NSPredicate predicateWithFormat: @"profile == %@", profile];
	
	NSArray *toCreate = [[self.groupRepository getAllByAttribute: @"syncStatus" value: @(DBSyncStatusCreated)] filteredArrayUsingPredicate: profilePredicate];
	[self addCreateRequestsWithEntities: toCreate forClassName: @"Group" forUser: userId];
	
	NSArray *toUpdate = [[self.groupRepository getAllByAttribute: @"syncStatus" value: @(DBSyncStatusEdited)] filteredArrayUsingPredicate: profilePredicate];
	[self addUpdateRequestsWithEntities: toUpdate forClassName: @"Group" forUser: userId];
	
	return [self.serviceClient executeBatchRequests];
}

- (void) addCreateRequestsWithEntities: (NSArray *) entities forClassName: (NSString *) className forUser: (NSString *) userId
{
	@weakify(self);
	[entities enumerateObjectsUsingBlock:^(SyncEntity *entity, NSUInteger idx, BOOL *stop) {
		@strongify(self);
		[self.serviceClient addCreateRequestForClassName: className withValues: [entity asDictionary] forUser: userId];
	}];
}

- (void) addUpdateRequestsWithEntities: (NSArray *) entities forClassName: (NSString *) className forUser: (NSString *) userId
{
	@weakify(self);
	[entities enumerateObjectsUsingBlock:^(SyncEntity *entity, NSUInteger idx, BOOL *stop) {
		@strongify(self);
		[self.serviceClient addUpdateRequestForClassName: className withValues: [entity asDictionary] forUser: userId];
	}];
}

- (NSDate *) dateForGroup
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"lastUpdated" ascending: NO];
	NSArray *latestGroup = [[self.groupRepository getAll] sortedArrayUsingDescriptors: @[sortDescriptor]];
	Group *group = [[latestGroup objectEnumerator] firstOrDefault];
	return group.lastUpdated;
}

@end
