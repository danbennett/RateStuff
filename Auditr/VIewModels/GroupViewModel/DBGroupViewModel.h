//
//  DBGroupViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;
@class DBAreaViewModel;
@protocol DBGroupService;
@protocol DBAreaService;

@interface DBGroupViewModel : NSObject

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong, readonly) RACSignal *valid;
@property (nonatomic, weak) Group *group;

- (id) initWithGroupService: (id<DBGroupService>) groupService
				areaService: (id<DBAreaService>) areaService;
- (DBAreaViewModel *) addArea;
- (void) deleteArea: (DBAreaViewModel *) viewModel;

@end
