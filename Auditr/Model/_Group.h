// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Group.h instead.

#import <CoreData/CoreData.h>


extern const struct GroupAttributes {
	__unsafe_unretained NSString *groupDescription;
	__unsafe_unretained NSString *groupName;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *lastUpdated;
	__unsafe_unretained NSString *softDeleted;
} GroupAttributes;

extern const struct GroupRelationships {
	__unsafe_unretained NSString *areas;
	__unsafe_unretained NSString *items;
	__unsafe_unretained NSString *profile;
} GroupRelationships;

extern const struct GroupFetchedProperties {
} GroupFetchedProperties;

@class Area;
@class Item;
@class Profile;








@interface GroupID : NSManagedObjectID {}
@end

@interface _Group : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GroupID*)objectID;





@property (nonatomic, strong) NSString* groupDescription;



//- (BOOL)validateGroupDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* groupName;



//- (BOOL)validateGroupName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* image;



//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastUpdated;



//- (BOOL)validateLastUpdated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* softDeleted;



@property BOOL softDeletedValue;
- (BOOL)softDeletedValue;
- (void)setSoftDeletedValue:(BOOL)value_;

//- (BOOL)validateSoftDeleted:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *areas;

- (NSMutableSet*)areasSet;




@property (nonatomic, strong) NSSet *items;

- (NSMutableSet*)itemsSet;




@property (nonatomic, strong) Profile *profile;

//- (BOOL)validateProfile:(id*)value_ error:(NSError**)error_;





@end

@interface _Group (CoreDataGeneratedAccessors)

- (void)addAreas:(NSSet*)value_;
- (void)removeAreas:(NSSet*)value_;
- (void)addAreasObject:(Area*)value_;
- (void)removeAreasObject:(Area*)value_;

- (void)addItems:(NSSet*)value_;
- (void)removeItems:(NSSet*)value_;
- (void)addItemsObject:(Item*)value_;
- (void)removeItemsObject:(Item*)value_;

@end

@interface _Group (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveGroupDescription;
- (void)setPrimitiveGroupDescription:(NSString*)value;




- (NSString*)primitiveGroupName;
- (void)setPrimitiveGroupName:(NSString*)value;




- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSData*)primitiveImage;
- (void)setPrimitiveImage:(NSData*)value;




- (NSDate*)primitiveLastUpdated;
- (void)setPrimitiveLastUpdated:(NSDate*)value;




- (NSNumber*)primitiveSoftDeleted;
- (void)setPrimitiveSoftDeleted:(NSNumber*)value;

- (BOOL)primitiveSoftDeletedValue;
- (void)setPrimitiveSoftDeletedValue:(BOOL)value_;





- (NSMutableSet*)primitiveAreas;
- (void)setPrimitiveAreas:(NSMutableSet*)value;



- (NSMutableSet*)primitiveItems;
- (void)setPrimitiveItems:(NSMutableSet*)value;



- (Profile*)primitiveProfile;
- (void)setPrimitiveProfile:(Profile*)value;


@end
