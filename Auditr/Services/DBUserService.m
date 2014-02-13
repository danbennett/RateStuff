//
//  DBUserService.m
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBUserService.h"
#import <Parse-iOS-SDK/Parse.h>

@implementation DBUserService

- (id) init
{
    self = [super init];
    if (self)
	{
		[PFUser enableAutomaticUser];
    }
    return self;
}

- (PFUser *) currentUser
{
	return [PFUser currentUser];
}

@end
