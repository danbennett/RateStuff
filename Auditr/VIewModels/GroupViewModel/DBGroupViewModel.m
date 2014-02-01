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
#import "Group.h"
#import "Area.h"
#import "Item.h"

@interface DBGroupViewModel()

@property (nonatomic, strong) Group *group;

@end

@implementation DBGroupViewModel

- (id) initWithGroup: (Group *) group
{
    self = [super init];
    if (self)
	{
        self.group = group;
		
		self.groupName = group.groupName;
		self.description = group.groupDescription;
		self.image = [UIImage imageWithData: self.group.image];
		[self createAreaViewModels];
		[self createItemsViewModels];
	
		[self createBindings];
		[self applyBindings];
    }
    return self;
}

- (void) createBindings
{
	self.valid = [RACSignal combineLatest:
	 @[RACObserve(self, groupName),
	   RACObserve(self, description)] reduce:^NSNumber *(NSString *name, NSString *description) {
		   BOOL nameValid = name.length > 0;
		   return @(nameValid);
	   }];
}

- (void) applyBindings
{
	RAC(self.group, groupName) = RACObserve(self, groupName);
	RAC(self.group, groupDescription) = RACObserve(self, description);
}

- (void) createAreaViewModels
{
	NSArray *areas = [self.group.areas allObjects];
	self.areas = [[[areas objectEnumerator] select:^DBAreaViewModel *(Area *area) {
		
		return [[DBAreaViewModel alloc] initWithArea: area];
		
	}] allObjects];
}

- (void) createItemsViewModels
{
	NSArray *items = [self.group.items allObjects];
	self.items = [[[items objectEnumerator] select:^DBItemViewModel *(Item *item) {
		
		return [[DBItemViewModel alloc] initWithItem: item];
		
	}] allObjects];
}

@end
