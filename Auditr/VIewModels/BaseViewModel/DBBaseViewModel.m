//
//  DBBaseViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewModel.h"
#import "DBGroupService.h"
#import "Group.h"
#import "DBGroupViewModel.h"
#import "DBAssembly.h"
#import <Typhoon/Typhoon.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBBaseViewModel()

@property (nonatomic, strong, readwrite) NSArray *groups;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, strong) NSArray *allGroups;

@end

@implementation DBBaseViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
{
	self = [super init];
	if(self)
	{
		self.groupService = groupService;
		
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
		
		self.groups = nil;
		
		self.groups =
		[[[[self.allGroups objectEnumerator] where:^BOOL(Group *group) {
			
			BOOL containsString = YES;
			if (filterString.length > 0)
			{
				containsString = ([group.groupName rangeOfString: filterString].location != NSNotFound);
			}
			return containsString;
			
		}] select:^DBGroupViewModel *(Group *group) {
			
			@strongify(self);
			DBGroupViewModel *viewModel = [self generateGroupViewModel];
			viewModel.group = group;
			return viewModel;
			
		}] allObjects];
		
	}];
}

- (void) deleteGroupViewModel: (DBGroupViewModel *) viewModel
{
	NSMutableArray *groups = [self.groups mutableCopy];
	[groups removeObject: viewModel];
	self.groups = [groups copy];
	
	[self.groupService deleteGroup: viewModel.group];
}

- (DBGroupViewModel *) newGroupViewModel
{
	Group *group = [self.groupService createBlankGroup];
	DBGroupViewModel *viewModel = [self generateGroupViewModel];
	viewModel.group = group;
	
	NSMutableArray *groups = [self.groups mutableCopy];
	[groups addObject: viewModel];
	self.groups = [groups copy];
	
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
	self.allGroups = [self.groupService getAllActive];
}

@end
