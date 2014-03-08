//
//  DBCoreDataItemRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 07/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBCoreDataItemRepository.h"
#import "Item.h"

@implementation DBCoreDataItemRepository

- (id) createEntity
{
	return [Item MR_createEntity];
}

- (NSArray *) getAll
{
	return [Item MR_findAll];
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	NSString *predicateString = [NSString stringWithFormat: @"%@ == %%@", attribute];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString, value];
	return [Item MR_findAllWithPredicate: predicate];
}

@end
