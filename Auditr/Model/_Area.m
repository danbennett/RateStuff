// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.m instead.

#import "_Area.h"

const struct AreaAttributes AreaAttributes = {
	.areaName = @"areaName",
	.id = @"id",
};

const struct AreaRelationships AreaRelationships = {
	.group = @"group",
	.items = @"items",
	.ratings = @"ratings",
};

const struct AreaFetchedProperties AreaFetchedProperties = {
};

@implementation AreaID
@end

@implementation _Area

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Area";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Area" inManagedObjectContext:moc_];
}

- (AreaID*)objectID {
	return (AreaID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic areaName;






@dynamic id;






@dynamic group;

	

@dynamic items;

	
- (NSMutableSet*)itemsSet {
	[self willAccessValueForKey:@"items"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"items"];
  
	[self didAccessValueForKey:@"items"];
	return result;
}
	

@dynamic ratings;

	
- (NSMutableSet*)ratingsSet {
	[self willAccessValueForKey:@"ratings"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ratings"];
  
	[self didAccessValueForKey:@"ratings"];
	return result;
}
	






@end
