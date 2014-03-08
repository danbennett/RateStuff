//
//  DBItemViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;
@protocol DBItemService;

@interface DBItemViewModel : NSObject

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong, readonly) RACSignal *valid;

- (id) initWithItemService: (id<DBItemService>) itemService;

@end
