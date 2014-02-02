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
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBBaseViewModel()

@property (nonatomic, strong, readwrite) RACSignal *groups;
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
	
	self.groups = [RACObserve(self, filterString) map:^NSArray *(NSString *filterString) {
		
		@strongify(self);
		NSArray *filteredGroups =
		[[[self.allGroups objectEnumerator] where:^BOOL(Group *group) {
			
			return ([group.groupName rangeOfString: filterString].location != NSNotFound);
			
		}] allObjects];
		
		return filteredGroups;
		
	}];
}

- (void) populateGroups
{
	self.allGroups = [self.groupService getAllActive];
}

@end
