// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.m instead.

#import "_Profile.h"

const struct ProfileAttributes ProfileAttributes = {
	.email = @"email",
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
	

	return keyPaths;
}




@dynamic email;






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
