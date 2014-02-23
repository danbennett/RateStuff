// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.m instead.

#import "_Profile.h"

const struct ProfileAttributes ProfileAttributes = {
	.active = @"active",
	.email = @"email",
	.parseUserId = @"parseUserId",
	.profileId = @"profileId",
	.profileImage = @"profileImage",
	.profileName = @"profileName",
};

const struct ProfileRelationships ProfileRelationships = {
	.groups = @"groups",
};

const struct ProfileFetchedProperties ProfileFetchedProperties = {
};

@implementation ProfileID
@end

@implementation _Profile

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Profile";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:moc_];
}

- (ProfileID*)objectID {
	return (ProfileID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"activeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"active"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic active;



- (BOOL)activeValue {
	NSNumber *result = [self active];
	return [result boolValue];
}

- (void)setActiveValue:(BOOL)value_ {
	[self setActive:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveActiveValue {
	NSNumber *result = [self primitiveActive];
	return [result boolValue];
}

- (void)setPrimitiveActiveValue:(BOOL)value_ {
	[self setPrimitiveActive:[NSNumber numberWithBool:value_]];
}





@dynamic email;






@dynamic parseUserId;






@dynamic profileId;






@dynamic profileImage;






@dynamic profileName;






@dynamic groups;

	
- (NSMutableSet*)groupsSet {
	[self willAccessValueForKey:@"groups"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"groups"];
  
	[self didAccessValueForKey:@"groups"];
	return result;
}
	






@end
