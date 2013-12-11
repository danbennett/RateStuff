// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.m instead.

#import "_Area.h"

const struct AreaAttributes AreaAttributes = {
	.areaName = @"areaName",
	.id = @"id",
	.score = @"score",
};

const struct AreaRelationships AreaRelationships = {
	.group = @"group",
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
	
	if ([key isEqualToString:@"scoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"score"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic areaName;






@dynamic id;






@dynamic score;



- (int32_t)scoreValue {
	NSNumber *result = [self score];
	return [result intValue];
}

- (void)setScoreValue:(int32_t)value_ {
	[self setScore:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveScoreValue {
	NSNumber *result = [self primitiveScore];
	return [result intValue];
}

- (void)setPrimitiveScoreValue:(int32_t)value_ {
	[self setPrimitiveScore:[NSNumber numberWithInt:value_]];
}





@dynamic group;

	






@end
