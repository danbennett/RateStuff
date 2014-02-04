//
//  DBBaseViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBGroupService.h"
@class DBGroupViewModel;

@interface DBBaseViewModel : NSObject
{
	
}

@property (nonatomic, strong, readonly) NSArray *groups;
@property (nonatomic, strong) NSString *filterString;

- (id) initWithGroupService: (id<DBGroupService>) groupService;
- (DBGroupViewModel *) newGroupViewModel;
- (void) deleteGroupViewModel: (DBGroupViewModel *) viewModel;

@end
