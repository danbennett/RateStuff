// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.h instead.

#import <CoreData/CoreData.h>


extern const struct ItemAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *itemDescription;
	__unsafe_unretained NSString *itemName;
} ItemAttributes;

extern const struct ItemRelationships {
	__unsafe_unretained NSString *group;
} ItemRelationships;

extern const struct ItemFetchedProperties {
} ItemFetchedProperties;

@class Group;






@interface ItemID : NSManagedObjectID {}
@end

@interface _Item : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ItemID*)objectID;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* image;



//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* itemDescription;



//- (BOOL)validateItemDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* itemName;



//- (BOOL)validateItemName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Group *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;





@end

@interface _Item (CoreDataGeneratedAccessors)

@end

@interface _Item (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSData*)primitiveImage;
- (void)setPrimitiveImage:(NSData*)value;




- (NSString*)primitiveItemDescription;
- (void)setPrimitiveItemDescription:(NSString*)value;




- (NSString*)primitiveItemName;
- (void)setPrimitiveItemName:(NSString*)value;





- (Group*)primitiveGroup;
- (void)setPrimitiveGroup:(Group*)value;


@end
