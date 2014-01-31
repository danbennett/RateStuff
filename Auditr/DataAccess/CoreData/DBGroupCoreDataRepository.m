//
//  DBGroupCoreDataRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBGroupCoreDataRepository.h"
#import "Group.h"

@implementation DBGroupCoreDataRepository

- (id) createEntity
{
	return [Group MR_createEntity];
}

- (NSArray *) getAll
{
	return [Group MR_findAll];
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	NSString *predicateString = [NSString stringWithFormat: @"%@ == %%@", attribute];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString, value];
	return [Group MR_findAllWithPredicate: predicate];
}

@end
