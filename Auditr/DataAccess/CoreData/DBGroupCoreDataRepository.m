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
	return [Group MR_findAllWithPredicate: [NSPredicate predicateWithFormat: @"%@ EQUALS %@", attribute, value]];
}

@end
