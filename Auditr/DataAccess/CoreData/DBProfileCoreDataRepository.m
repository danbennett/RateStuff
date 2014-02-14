//
//  DBProfileCoreDataRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 13/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBProfileCoreDataRepository.h"
#import "Profile.h"

@implementation DBProfileCoreDataRepository

- (id) createEntity
{
	return [Profile MR_createEntity];
}

- (NSArray *) getAll
{
	return [Profile MR_findAll];
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	NSString *predicateString = [NSString stringWithFormat: @"%@ == %%@", attribute];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString, value];
	return [Profile MR_findAllWithPredicate: predicate];
}

@end
