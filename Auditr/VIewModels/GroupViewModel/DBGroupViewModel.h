//
//  DBGroupViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;
@class DBItemViewModel;
@class Group;
@class DBAreaViewModel;
@protocol DBGroupService;
@protocol DBAreaService;
@protocol DBItemService;

@interface DBGroupViewModel : NSObject

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupDescription;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong, readonly) UIImage *thumbnail;
@property (nonatomic, strong, readonly) NSArray *areas;
@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, strong, readonly) RACSignal *valid;
@property (nonatomic, strong, readonly) RACCommand *saveCommand;
@property (nonatomic, strong, readonly) RACSignal *saved;
@property (nonatomic, weak) Group *group;

- (id) initWithGroupService: (id<DBGroupService>) groupService
				areaService: (id<DBAreaService>) areaService
				itemService: (id<DBItemService>) itemService;

- (DBAreaViewModel *) addArea;
- (void) deleteArea: (DBAreaViewModel *) viewModel;
- (DBItemViewModel *) addItem;
- (void) deleteItem: (DBItemViewModel *) viewModel;

@end
