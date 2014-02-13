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
@protocol DBTwitterAuthService;

@interface DBHomeViewModel : NSObject

- (id) initWithGroupService: (id<DBGroupService>) groupService
				authService: (id<DBTwitterAuthService>) twitterAuthService;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
