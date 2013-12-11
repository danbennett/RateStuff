// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.m instead.

#import "_Item.h"

const struct ItemAttributes ItemAttributes = {
	.id = @"id",
	.image = @"image",
	.itemDescription = @"itemDescription",
	.itemName = @"itemName",
};

const struct ItemRelationships ItemRelationships = {
	.group = @"group",
};

const struct ItemFetchedProperties ItemFetchedProperties = {
};

@implementation ItemID
@end

@implementation _Item

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Item";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Item" inManagedObjectContext:moc_];
}

- (ItemID*)objectID {
	return (ItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic id;






@dynamic image;






@dynamic itemDescription;






@dynamic itemName;






@dynamic group;

	






@end
