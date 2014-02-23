//
//  DBSyncEntityCoreDataRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 23/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSyncEntityCoreDataRepository.h"
#import "SyncEntity.h"

@implementation DBSyncEntityCoreDataRepository

- (id) createEntity
{
	return [SyncEntity MR_createEntity];
}

- (NSArray *) getAll
{
	return [SyncEntity MR_findAll];
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	NSString *predicateString = [NSString stringWithFormat: @"%@ == %%@", attribute];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: predicateString, value];
	return [SyncEntity MR_findAllWithPredicate: predicate];
}

@end
