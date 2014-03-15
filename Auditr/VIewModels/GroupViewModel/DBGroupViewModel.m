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
#import "DBItemService.h"
#import "Group.h"
#import "Area.h"
#import "Item.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "UIImage+Scaling.h"

@interface DBGroupViewModel()

@property (nonatomic, strong, readwrite) NSArray *areas;
@property (nonatomic, strong, readwrite) NSArray *items;
@property (nonatomic, strong, readwrite) UIImage *thumbnail;
@property (nonatomic, strong, readwrite) RACSignal *valid;
@property (nonatomic, strong, readwrite) RACCommand *saveCommand;
@property (nonatomic, strong, readwrite) RACSubject *saved;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBAreaService> areaService;
@property (nonatomic, assign) id<DBItemService> itemService;

@end

@implementation DBGroupViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
				areaService: (id<DBAreaService>) areaService
				itemService: (id<DBItemService>) itemService
{
    self = [super init];
    if (self)
	{
		self.groupService = groupService;
		self.areaService = areaService;
		self.itemService = itemService;
		
		[self createBindings];
    }
    return self;
}

#pragma mark - Bindings.

- (void) createBindings
{
	@weakify(self);
	[[RACObserve(self, group) distinctUntilChanged] subscribeNext:^(Group *group) {
	
		@strongify(self);
		self.groupName = group.groupName;
		self.groupDescription = group.groupDescription;
		[self loadImageWithData: group.image];
		[self createAreaViewModels];
		[self createItemsViewModels];

		[self createGroupBindings];
		[self applyBindings];
	}];
	
	self.saveCommand = [[RACCommand alloc] initWithEnabled: self.valid signalBlock:^RACSignal *(id input) {
		
		@strongify(self);
		return [self saved];
	}];
}

- (void) loadImageWithData: (NSData *) data
{
	@weakify(self);
	
	if (data != nil)
	{
		dispatch_queue_t imageQueue = dispatch_queue_create("uk.co.bennettdan.imageUnarchiver", NULL);
		dispatch_async(imageQueue, ^{
			
			@strongify(self);

			UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData: data];
			UIImage *thumbnail = [UIImage imageWithImage: image scaledToFillSize: CGSizeMake(40.f, 40.f)];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				@strongify(self);
				self.image = image;
				self.thumbnail = thumbnail;
			});
		});
	}
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
	RAC(self.group, groupDescription) = RACObserve(self, groupDescription);
	
	@weakify(self);
	[RACObserve(self, image) subscribeNext:^(UIImage *image) {
		
		if (image != nil)
		{
			__block NSData *data = nil;
		
			dispatch_queue_t imageQueue = dispatch_queue_create("uk.co.bennettdan.imageArchiver", NULL);
			
			dispatch_async(imageQueue, ^{
				
				data = [NSKeyedArchiver archivedDataWithRootObject: image];
				UIImage *thumbnail = [UIImage imageWithImage: image scaledToFillSize: CGSizeMake(40.f, 40.f)];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					self.group.image = data;
					self.thumbnail = thumbnail;
				});
			});
		}
		
	}];
}

#pragma mark - Save

- (RACSignal *) saved
{
	@weakify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
	
		@strongify(self);
		[self.groupService saveGroup: self.group toPush: YES withCompletion:^(BOOL success, NSError *error) {
			if (success)
			{
				[subscriber sendNext: [NSNull null]];
				[subscriber sendCompleted];
			}
			else
			{
				[subscriber sendError: error];
			}
		}];
		return nil;
	}];
}

#pragma mark view models.

- (void) createAreaViewModels
{
	NSArray *areas = [self.group.areas allObjects];
	@weakify(self);
	self.areas = [[[areas objectEnumerator] select:^DBAreaViewModel *(Area *area) {
		
		@strongify(self);
		DBAreaViewModel *viewModel = [self generateAreaViewModel];
		viewModel.area = area;
		return viewModel;
		
	}] allObjects];
}

- (void) createItemsViewModels
{
	NSArray *items = [self.group.items allObjects];
	
	self.items = [[[items objectEnumerator] select:^DBItemViewModel *(Item *item) {
		
		DBItemViewModel *viewModel = [self generateItemViewModel];
		viewModel.item = item;
		return viewModel;
		
	}] allObjects];
	
	self.items = @[[[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init], [[DBItemViewModel alloc] init]];
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
	[self.areaService deleteArea: area hard: NO];
}

- (DBItemViewModel *) addItem
{
	Item *item = [self.itemService createItem];
	[self.groupService addItem: item toGroup: self.group];
	
	// Create view model.
	DBItemViewModel *viewModel = [self generateItemViewModel];
	viewModel.item = item;
	
	// Add item to items array.
	NSMutableArray *items = [self.items mutableCopy];
	[items insertObject: viewModel atIndex: 0];
	self.items = [items copy];
	
	return viewModel;
}

- (void) deleteItem: (DBItemViewModel *) viewModel
{
	NSMutableArray *items = [self.items mutableCopy];
	[items removeObject: viewModel];
	self.items = [items copy];
	
	Item *item = viewModel.item;
	[self.itemService deleteItem: item hard: NO];
}

- (DBAreaViewModel *) generateAreaViewModel
{
	DBAssembly *assembly = (DBAssembly *) [TyphoonAssembly defaultAssembly];
	
	id<DBAreaService> service = [assembly areaService];
	
	return [[DBAreaViewModel alloc] initWithAreaService: service];
}

- (DBItemViewModel *) generateItemViewModel
{
	DBAssembly *assembly = (DBAssembly *) [TyphoonAssembly defaultAssembly];
	
	id<DBItemService> service = [assembly itemService];
	
	return [[DBItemViewModel alloc] initWithItemService: service];

}

@end
