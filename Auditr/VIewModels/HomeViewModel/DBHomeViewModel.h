//
//  DBHomeViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBGroupViewModel;
@protocol DBGroupService;

@interface DBHomeViewModel : NSObject

@property (nonatomic, strong, readonly) NSString *title;
- (id) initWithGroupService: (id<DBGroupService>) groupService;
- (DBGroupViewModel *) newGroupViewModel;

@end
