// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.h instead.

#import <CoreData/CoreData.h>
#import "SyncEntity.h"

extern const struct AreaAttributes {
	__unsafe_unretained NSString *areaName;
} AreaAttributes;

extern const struct AreaRelationships {
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *items;
	__unsafe_unretained NSString *ratings;
} AreaRelationships;

extern const struct AreaFetchedProperties {
} AreaFetchedProperties;

@class Group;
@class Item;
@class Rating;



@interface AreaID : NSManagedObjectID {}
@end

@interface _Area : SyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AreaID*)objectID;





@property (nonatomic, strong) NSString* areaName;



//- (BOOL)validateAreaName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Group *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *items;

- (NSMutableSet*)itemsSet;




@property (nonatomic, strong) NSSet *ratings;

- (NSMutableSet*)ratingsSet;





@end

@interface _Area (CoreDataGeneratedAccessors)

- (void)addItems:(NSSet*)value_;
- (void)removeItems:(NSSet*)value_;
- (void)addItemsObject:(Item*)value_;
- (void)removeItemsObject:(Item*)value_;

- (void)addRatings:(NSSet*)value_;
- (void)removeRatings:(NSSet*)value_;
- (void)addRatingsObject:(Rating*)value_;
- (void)removeRatingsObject:(Rating*)value_;

@end

@interface _Area (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAreaName;
- (void)setPrimitiveAreaName:(NSString*)value;





- (Group*)primitiveGroup;
- (void)setPrimitiveGroup:(Group*)value;



- (NSMutableSet*)primitiveItems;
- (void)setPrimitiveItems:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRatings;
- (void)setPrimitiveRatings:(NSMutableSet*)value;


@end
