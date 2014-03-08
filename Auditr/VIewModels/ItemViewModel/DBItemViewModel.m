//
//  DBItemViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemViewModel.h"
#import "DBItemService.h"
#import "Item.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBItemViewModel()

@property (nonatomic, assign) id<DBItemService> itemService;
@property (nonatomic, strong, readwrite) RACSignal *valid;

@end

@implementation DBItemViewModel

- (id) initWithItemService: (id<DBItemService>) itemService
{
    self = [super init];
    if (self)
	{
		self.itemService = itemService;
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	@weakify(self);
	[RACObserve(self, item) subscribeNext:^(Item *item) {
		
		@strongify(self);
		if (item != nil)
		{
			self.itemName = item.itemName;
			
			[self createItemBindings];
			[self applyBindings];
		}
	}];
}

- (void) createItemBindings
{
	self.valid = [RACSignal combineLatest:
				  @[RACObserve(self, itemName)] reduce:^NSNumber *(NSString *name) {
					  BOOL nameValid = name.length > 0;
					  return @(nameValid);
				  }];
}

- (void) applyBindings
{
	RAC(self.item, itemName) = RACObserve(self, itemName);
}

@end
