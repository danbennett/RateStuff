//
//  DBGroupSyncManager.m
//  Auditr
//
//  Created by Daniel Bennett on 03/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBGroupSyncManager.h"
#import "DBGroupService.h"
#import "DBParseServiceClient.h"
#import "DBProfileService.h"
#import "Profile.h"
#import "Group.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBGroupSyncManager()

@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBParseServiceClient> serviceClient;
@property (nonatomic, assign) id<DBProfileService> profileService;

@end

@implementation DBGroupSyncManager

- (id) initWithGroupService: (id<DBGroupService>) groupService
		 parseServiceClient: (id<DBParseServiceClient>) serviceClient
			 profileService: (id<DBProfileService>) profileService
{
    self = [super init];
    if (self)
	{
        self.groupService = groupService;
		self.serviceClient = serviceClient;
		self.profileService = profileService;
    }
    return self;
}

- (RACSignal *) push
{
	NSString *userId = [self.profileService currentProfile].parseUserId;

	@weakify(self);
	[[self.groupService getAllCreated] enumerateObjectsUsingBlock:^(Group *group, NSUInteger idx, BOOL *stop) {
		@strongify(self);
		[self.serviceClient addCreateRequestForClassName: @"Group" withValues: [group asDictionary] forUser: userId];
	}];
	
	[[self.groupService getAllEdited] enumerateObjectsUsingBlock:^(Group *group, NSUInteger idx, BOOL *stop) {
		@strongify(self);
		[self.serviceClient addUpdateRequestForClassName: @"Group" withValues: [group asDictionary] forUser: userId];
	}];
	
	[[self.groupService getAllDeleted] enumerateObjectsUsingBlock:^(Group *group, NSUInteger idx, BOOL *stop) {
		@strongify(self);
		[self.serviceClient addDeleteRequestForClassName: @"Group" forUser: userId];
	}];
	
	return [self.serviceClient executeBatchRequests];
}

@end
