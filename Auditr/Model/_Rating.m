// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rating.m instead.

#import "_Rating.h"

const struct RatingAttributes RatingAttributes = {
	.score = @"score",
};

const struct RatingRelationships RatingRelationships = {
	.area = @"area",
	.item = @"item",
};

const struct RatingFetchedProperties RatingFetchedProperties = {
};

@implementation RatingID
@end

@implementation _Rating

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Rating" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Rating";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Rating" inManagedObjectContext:moc_];
}

- (RatingID*)objectID {
	return (RatingID*)[super objectID];
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





@dynamic area;

	

@dynamic item;

	






@end
