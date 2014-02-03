//
//  DBAreaViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaViewModel.h"
#import "DBAreaService.h"
#import "Area.h"

@interface DBAreaViewModel()

@property (nonatomic, strong, readwrite) RACSignal *valid;
@property (nonatomic, assign) id<DBAreaService> areaService;
@property (nonatomic, strong, readwrite) NSString *areaName;

@end

@implementation DBAreaViewModel

- (id) initWithAreaService: (id<DBAreaService>) areaService
{
    self = [super init];
    if (self)
	{
		self.areaService = areaService;
		[self createBindings];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	[[RACObserve(self, area) distinctUntilChanged] subscribeNext:^(Area *area) {
		
		self.areaName = area.areaName;
		[self createItemViewModels];
		[self createRatingViewModels];
		
		[self createAreaBindings];
		[self applyBindings];
	}];
}

- (void) createItemViewModels
{
	
}

- (void) createRatingViewModels
{
	
}

- (void) createAreaBindings
{
	self.valid = [RACSignal combineLatest:
				  @[RACObserve(self, areaName)] reduce:^NSNumber *(NSString *name) {
						BOOL nameValid = name.length > 0;
						return @(nameValid);
					}];
}

- (void) applyBindings
{
	RAC(self.area, areaName) = RACObserve(self, areaName);
}

@end
