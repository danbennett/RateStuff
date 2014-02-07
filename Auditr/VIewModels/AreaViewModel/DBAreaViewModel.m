//
//  DBAreaViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaViewModel.h"
#import "DBAreaService.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "Area.h"

@interface DBAreaViewModel()

@property (nonatomic, strong) NSMutableArray *disposables;
@property (nonatomic, strong, readwrite) RACSignal *valid;
@property (nonatomic, assign) id<DBAreaService> areaService;

@end

@implementation DBAreaViewModel

- (id) initWithAreaService: (id<DBAreaService>) areaService
{
    self = [super init];
    if (self)
	{
		self.areaService = areaService;
		self.disposables = [NSMutableArray array];
		[self createBindings];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	@weakify(self);
	[RACObserve(self, area) subscribeNext:^(Area *area) {
	
		@strongify(self);
		if (area != nil)
		{
			self.name = area.areaName;
			[self createItemViewModels];
			[self createRatingViewModels];
			
			[self createAreaBindings];
			[self applyBindings];
		}
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
				  @[RACObserve(self, name)] reduce:^NSNumber *(NSString *name) {
						BOOL nameValid = name.length > 0;
						return @(nameValid);
					}];
}

- (void) applyBindings
{
	RAC(self.area, areaName) = RACObserve(self, name);
}

@end
