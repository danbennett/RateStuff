//
//  DBGroupViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBGroupViewModel.h"
#import "DBAreaViewModel.h"
#import "DBItemViewModel.h"
#import "DBGroupService.h"
#import "DBAreaService.h"
#import "Group.h"
#import "Area.h"
#import "Item.h"

@interface DBGroupViewModel()

@property (nonatomic, strong, readwrite) RACSignal *valid;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBAreaService> areaService;

@end

@implementation DBGroupViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
				areaService: (id<DBAreaService>) areaService
{
    self = [super init];
    if (self)
	{
		self.groupService = groupService;
		self.areaService = areaService;
		[self createBindings];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	[[RACObserve(self, group) distinctUntilChanged] subscribeNext:^(Group *group) {
		
		self.groupName = group.groupName;
		self.description = group.groupDescription;
		self.image = [UIImage imageWithData: self.group.image];
		[self createAreaViewModels];
		[self createItemsViewModels];

		[self createGroupBindings];
		[self applyBindings];
	}];
}

- (void) createGroupBindings
{
	self.valid = [RACSignal combineLatest:
				  @[RACObserve(self, groupName)] reduce:^NSNumber *(NSString *name) {
						BOOL nameValid = name.length > 0;
						return @(nameValid);
					}];
}

- (void) applyBindings
{
	RAC(self.group, groupName) = RACObserve(self, groupName);
	RAC(self.group, groupDescription) = RACObserve(self, description);
}

#pragma mark view models.

- (void) createAreaViewModels
{
	NSArray *areas = [self.group.areas allObjects];
	self.areas = [[[areas objectEnumerator] select:^DBAreaViewModel *(Area *area) {
		
		DBAreaViewModel *viewModel = [self generateAreaViewModel];
		viewModel.area = area;
		return viewModel;
		
	}] allObjects];
}

- (void) createItemsViewModels
{
	NSArray *items = [self.group.items allObjects];
	self.items = [[[items objectEnumerator] select:^DBItemViewModel *(Item *item) {
		
		return [[DBItemViewModel alloc] initWithItem: item];
		
	}] allObjects];
}

- (DBAreaViewModel *) addArea
{
	// Create area.
	Area *area = [self.areaService createArea];
	[self.groupService addArea: area toGroup: self.group];
	
	// Create area viewmodel.
	DBAreaViewModel *viewModel = [self generateAreaViewModel];
	viewModel.area = area;
	
	// Add to areas array.
	NSMutableArray *areas = [self.areas mutableCopy];
	[areas insertObject: viewModel atIndex: 0];
	self.areas = [areas copy];
	
	return viewModel;
}

- (void) deleteArea: (DBAreaViewModel *) viewModel
{
	// Remove from areas array.
	NSMutableArray *areas = [self.areas mutableCopy];
	[areas removeObject: viewModel];
	self.areas = [areas copy];
	
	// Delete area.
	Area *area = viewModel.area;
	[self.areaService deleteArea: area];
}

- (DBAreaViewModel *) generateAreaViewModel
{
	DBAssembly *assembly = (DBAssembly *) [TyphoonAssembly defaultAssembly];
	return (DBAreaViewModel *) [assembly areaViewModel];
}

@end
