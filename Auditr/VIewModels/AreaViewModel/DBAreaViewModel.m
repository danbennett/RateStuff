//
//  DBAreaViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaViewModel.h"
#import "Area.h"

@interface DBAreaViewModel()

@property (nonatomic, strong) Area *area;

@end

@implementation DBAreaViewModel

- (id) initWithArea: (Area *) area
{
    self = [super init];
    if (self)
	{
		self.area = area;
    }
    return self;
}

@end
