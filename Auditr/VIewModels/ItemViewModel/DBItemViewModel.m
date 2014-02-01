//
//  DBItemViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemViewModel.h"
#import "Item.h"

@interface DBItemViewModel()

@property (nonatomic, strong) Item *item;

@end

@implementation DBItemViewModel

- (id) initWithItem: (Item *) item
{
    self = [super init];
    if (self)
	{
		self.item = item;
    }
    return self;
}

@end
