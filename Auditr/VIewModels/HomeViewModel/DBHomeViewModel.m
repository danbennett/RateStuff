//
//  DBHomeViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBHomeViewModel.h"
#import "DBProfileViewModel.h"
#import "DBGroupService.h"
#import "DBGroupViewModel.h"
#import "DBProfileService.h"
#import <Parse-iOS-SDK/Parse.h>

@interface DBHomeViewModel()

@property (nonatomic, strong, readwrite) DBProfileViewModel *profileViewModel;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBProfileService> profileService;

@end

@implementation DBHomeViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
				authService: (id<DBProfileService>) profileService
{
    self = [super init];
    if (self)
	{
		self.groupService = groupService;
		self.profileService = profileService;
		
		[self loadProfileViewModel];
		[self createBindings];
    }
    return self;
}

#pragma mark - Profile.

- (void) loadProfileViewModel
{
	Profile *profile = [self.profileService currentProfile];
	
	DBAssembly *assembly = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	id<DBProfileService> profileService = [assembly profileService];
	id<DBParseService> parseService = [assembly parseService];
	
	self.profileViewModel = [[DBProfileViewModel alloc] initWithProfileService: profileService parseService: parseService];
	self.profileViewModel.profile = profile;
}

- (DBGroupViewModel *) newGroupViewModel
{
	Group *group = [self.groupService createBlankGroup];
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	
	id<DBGroupService> groupService = [factory groupService];
	id<DBAreaService> areaService = [factory areaService];
	
	DBGroupViewModel *viewModel = [[DBGroupViewModel alloc] initWithGroupService: groupService areaService: areaService];
	viewModel.group = group;
	
	return viewModel;
}

#pragma mark - Bindings.

- (void) createBindings
{
	
}

@end
