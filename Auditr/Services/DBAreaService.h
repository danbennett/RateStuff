//
//  DBAreaService.h
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Area;
@protocol DBAreaRepository;

@protocol DBAreaService <NSObject>
- (Area *) createAreaWithName: (NSString *) areaName;

@end

@interface DBAreaService : NSObject

- (id) initWithAreaRepository: (id<DBAreaRepository>) areaRepository;
- (Area *) createAreaWithName: (NSString *) areaName;

@end
