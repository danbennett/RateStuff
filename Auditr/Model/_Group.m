// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.m instead.

#import "_Group.h"

const struct GroupAttributes GroupAttributes = {
	.groupName = @"groupName",
	.id = @"id",
	.image = @"image",
};

const struct GroupRelationships GroupRelationships = {
	.areas = @"areas",
	.items = @"items",
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
	

	return keyPaths;
}




@dynamic groupName;






@dynamic id;






@dynamic image;






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
	






@end
