//
//  DBBaseViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBGroupService.h"

@interface DBBaseViewModel : NSObject

- (id) initWithGroupService: (id<DBGroupService>) groupService;

@end
