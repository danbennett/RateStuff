//
//  DBAreaViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Area;
@protocol DBAreaService;

@interface DBAreaViewModel : NSObject

@property (nonatomic, weak) Area *area;
@property (nonatomic, strong, readonly) NSString *areaName;
@property (nonatomic, strong, readonly) RACSignal *valid;

- (id) initWithAreaService: (id<DBAreaService>) areaService;

@end
