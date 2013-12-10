//
//  DBCoreDataBaseRepository.m
//  Auditr
//
//  Created by Daniel Bennett on 10/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBCoreDataBaseRepository.h"
#import <MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>

@implementation DBCoreDataBaseRepository

- (id) createEntity
{
	return nil;
}

- (NSArray *) getAll
{
	return nil;
}

- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value
{
	return nil;
}

- (BOOL) saveEntity:(id) entity
{
	NSManagedObjectContext *context = ((NSManagedObject *) entity).managedObjectContext;
	[context MR_saveOnlySelfAndWait];
	BOOL success = !(context.hasChanges);
	return success;
}

- (void) save:(id) entity withCompletion: (void (^)(BOOL success, NSError *error)) completionHandler
{
	NSManagedObjectContext *context = ((NSManagedObject *) entity).managedObjectContext;
	[context MR_saveOnlySelfWithCompletion: completionHandler];
}

- (void) deleteEntity: (id) entity
{
	[entity MR_deleteEntity];
}

- (void) insertObject: (id) object atKey: (NSString *) key onEntity: (id) entity
{
	NSSet *changedObjects = [[NSSet alloc] initWithObjects: &object count: 1];
	[entity willChangeValueForKey: key withSetMutation: NSKeyValueMinusSetMutation usingObjects: changedObjects];
	[[entity primitiveValueForKey: key] addObject: object];
	[entity didChangeValueForKey: key withSetMutation: NSKeyValueUnionSetMutation usingObjects: changedObjects];
}

- (void) addObject: (id) object forKey: (NSString *) key onEntity: (id) entity
{
	[entity willChangeValueForKey: key];
    id objectCopy = [object copy];
    [entity setPrimitiveValue: objectCopy forKey: key];
    [self didChangeValueForKey: key];
}

@end
