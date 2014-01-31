//
//  DBHomeViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBHomeViewModel.h"

@interface DBHomeViewModel()

//@property (nonatomic, strong, readwrite) NSString *title;

@end

@implementation DBHomeViewModel


- (id)init
{
    self = [super init];
    if (self)
	{
		self.title = @"Home";
    }
    return self;
}

@end
