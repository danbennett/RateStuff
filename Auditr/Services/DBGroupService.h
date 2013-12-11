//
//  DBGroupService.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBGroupRepository.h"

@protocol DBGroupService <NSObject>

@required
- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository;

@end

@interface DBGroupService : NSObject

- (id) initWithGroupRepository: (id<DBGroupRepository>) groupRepository;

@end
