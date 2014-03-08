//
//  DBItemService.m
//  Auditr
//
//  Created by Daniel Bennett on 07/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemService.h"
#import "DBItemRepository.h"
#import "Item.h"

@interface DBItemService()

@property (nonatomic, assign) id<DBItemRepository> itemRepository;

@end

@implementation DBItemService

- (id) initWithItemRepository: (id<DBItemRepository>) itemRepository
{
    self = [super init];
    if (self)
	{
		self.itemRepository = itemRepository;
    }
    return self;
}

- (Item *) createItem
{
	Item *item = [self.itemRepository createEntity];
	item.syncStatus = @(DBSyncStatusCreated);
	return item;
}

- (void) deleteItem: (Item *) item hard: (BOOL) isHardDelete
{
	if (isHardDelete || [item.syncStatus isEqual: @(DBSyncStatusCreated)])
	{
		[self.itemRepository deleteEntity: item];
		return;
	}
	item.syncStatus = @(DBSyncStatusDeleted);
}

@end
