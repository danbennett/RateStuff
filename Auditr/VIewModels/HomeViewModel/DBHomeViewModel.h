//
//  DBHomeViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBGroupViewModel;
@class DBProfileViewModel;
@protocol DBGroupService;
@protocol DBProfileService;

@interface DBHomeViewModel : NSObject

@property (nonatomic, strong, readonly) DBProfileViewModel *profileViewModel;

- (id) initWithGroupService: (id<DBGroupService>) groupService
				authService: (id<DBProfileService>) profileService;

@end
