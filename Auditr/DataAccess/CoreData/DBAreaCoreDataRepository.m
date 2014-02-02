//
//  DBAreaCoreDataRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaCoreDataRepository.h"
#import "Area.h"

@implementation DBAreaCoreDataRepository

- (id) createEntity
{
	return [Area MR_createEntity];
}

- (NSArray *) getAll
{
	return [Area MR_findAll];
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	NSString *predicateString = [NSString stringWithFormat: @"%@ == %%@", attribute];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString, value];
	return [Area MR_findAllWithPredicate: predicate];
}

@end
