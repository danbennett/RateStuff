//
//  DBItemService.h
//  Auditr
//
//  Created by Daniel Bennett on 07/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBItemRepository;
@class Item;

@protocol DBItemService <NSObject>

- (id) initWithItemRepository: (id<DBItemRepository>) itemRepository;
- (Item *) createItem;
- (void) deleteItem: (Item *) item hard: (BOOL) isHardDelete;

@end

@interface DBItemService : NSObject

- (id) initWithItemRepository: (id<DBItemRepository>) itemRepository;
- (Item *) createItem;
- (void) deleteItem: (Item *) item hard: (BOOL) isHardDelete;

@end
