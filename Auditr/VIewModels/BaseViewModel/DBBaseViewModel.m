//
//  DBBaseViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewModel.h"
#import "DBGroupService.h"
#import "DBProfileService.h"
#import "Group.h"
#import "DBGroupViewModel.h"
#import "DBAssembly.h"
#import <Typhoon/Typhoon.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBBaseViewModel()

@property (nonatomic, strong, readwrite) NSArray *groups;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBProfileService> profileService;
@property (nonatomic, strong) NSArray *allGroups;

@end

@implementation DBBaseViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
			 profileService: (id<DBProfileService>) profileService
{
	self = [super init];
	if(self)
	{
		self.groupService = groupService;
		self.profileService = profileService;
		
		[self populateGroups];
		[self filterGroups];
	}
	return self;
}

- (void) filterGroups
{
	@weakify(self);
	
	[RACObserve(self, filterString) subscribeNext:^(NSString *filterString) {
		
		@strongify(self);
		
		[self filterGroupsWithString: filterString];
		
	}];
}

- (void) filterGroupsWithString: (NSString *) filterString
{
	self.groups = nil;
	
	self.groups =
	[[[self.allGroups objectEnumerator] where:^BOOL(DBGroupViewModel *groupViewModel) {
		BOOL containsString = YES;
		if (filterString.length > 0)
		{
			containsString = ([groupViewModel.groupName rangeOfString: filterString].location != NSNotFound);
		}
		return containsString;
	}] allObjects ];
}

- (void) deleteGroupViewModel: (DBGroupViewModel *) viewModel
{
	NSMutableArray *allGroups = [self.allGroups mutableCopy];
	[allGroups removeObject: viewModel];
	self.allGroups = allGroups;
	
	[self filterGroupsWithString: self.filterString];
	
	[self.groupService deleteGroup: viewModel.group hard: NO];
}

- (DBGroupViewModel *) newGroupViewModel
{
	Group *group = [self.groupService createBlankGroup];
	DBGroupViewModel *viewModel = [self generateGroupViewModel];
	viewModel.group = group;
	
	NSMutableArray *allGroups = [self.allGroups mutableCopy];
	[allGroups addObject: viewModel];
	self.allGroups = [allGroups copy];
	
	[self filterGroupsWithString: self.filterString];
	
	return viewModel;
}

- (DBGroupViewModel *) generateGroupViewModel
{
	DBAssembly *assembly = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	
	id<DBGroupService> groupService = [assembly groupService];
	id<DBAreaService> areaService = [assembly areaService];
	
	return [[DBGroupViewModel alloc] initWithGroupService: groupService areaService: areaService];
}

- (void) populateGroups
{
	NSArray *groups = [self.groupService getAll];
	
	self.allGroups = [[[groups objectEnumerator] select:^DBGroupViewModel *(Group *group) {
		
		DBGroupViewModel *viewModel = [self generateGroupViewModel];
		viewModel.group = group;
		return viewModel;
		
	}] allObjects ];
}

@end
