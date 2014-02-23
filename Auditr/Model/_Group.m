// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.m instead.

#import "_Group.h"

const struct GroupAttributes GroupAttributes = {
	.groupDescription = @"groupDescription",
	.groupName = @"groupName",
	.image = @"image",
	.lastUpdated = @"lastUpdated",
	.softDeleted = @"softDeleted",
};

const struct GroupRelationships GroupRelationships = {
	.areas = @"areas",
	.items = @"items",
	.profile = @"profile",
};

const struct GroupFetchedProperties GroupFetchedProperties = {
};

@implementation GroupID
@end

@implementation _Group

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Group";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Group" inManagedObjectContext:moc_];
}

- (GroupID*)objectID {
	return (GroupID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"softDeletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"softDeleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic groupDescription;






@dynamic groupName;






@dynamic image;






@dynamic lastUpdated;






@dynamic softDeleted;



- (BOOL)softDeletedValue {
	NSNumber *result = [self softDeleted];
	return [result boolValue];
}

- (void)setSoftDeletedValue:(BOOL)value_ {
	[self setSoftDeleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSoftDeletedValue {
	NSNumber *result = [self primitiveSoftDeleted];
	return [result boolValue];
}

- (void)setPrimitiveSoftDeletedValue:(BOOL)value_ {
	[self setPrimitiveSoftDeleted:[NSNumber numberWithBool:value_]];
}





@dynamic areas;

	
- (NSMutableSet*)areasSet {
	[self willAccessValueForKey:@"areas"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"areas"];
  
	[self didAccessValueForKey:@"areas"];
	return result;
}
	

@dynamic items;

	
- (NSMutableSet*)itemsSet {
	[self willAccessValueForKey:@"items"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"items"];
  
	[self didAccessValueForKey:@"items"];
	return result;
}
	

@dynamic profile;

	






@end
