//
//  DBBaseViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewModel.h"
#import "DBGroupService.h"

@interface DBBaseViewModel()

@property (nonatomic, assign) id<DBGroupService> groupService;

@end

@implementation DBBaseViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
{
	self = [super init];
	if(self)
	{
		self.groupService = groupService;
	}
	return self;
}

@end
