// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncEntity.m instead.

#import "_SyncEntity.h"

const struct SyncEntityAttributes SyncEntityAttributes = {
	.syncId = @"syncId",
	.syncStatus = @"syncStatus",
};

const struct SyncEntityRelationships SyncEntityRelationships = {
};

const struct SyncEntityFetchedProperties SyncEntityFetchedProperties = {
};

@implementation SyncEntityID
@end

@implementation _SyncEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SyncEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SyncEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SyncEntity" inManagedObjectContext:moc_];
}

- (SyncEntityID*)objectID {
	return (SyncEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"syncStatusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"syncStatus"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic syncId;






@dynamic syncStatus;



- (int32_t)syncStatusValue {
	NSNumber *result = [self syncStatus];
	return [result intValue];
}

- (void)setSyncStatusValue:(int32_t)value_ {
	[self setSyncStatus:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSyncStatusValue {
	NSNumber *result = [self primitiveSyncStatus];
	return [result intValue];
}

- (void)setPrimitiveSyncStatusValue:(int32_t)value_ {
	[self setPrimitiveSyncStatus:[NSNumber numberWithInt:value_]];
}










@end
