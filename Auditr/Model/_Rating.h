// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rating.h instead.

#import <CoreData/CoreData.h>


extern const struct RatingAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *score;
} RatingAttributes;

extern const struct RatingRelationships {
	__unsafe_unretained NSString *area;
	__unsafe_unretained NSString *item;
} RatingRelationships;

extern const struct RatingFetchedProperties {
} RatingFetchedProperties;

@class Area;
@class Item;




@interface RatingID : NSManagedObjectID {}
@end

@interface _Rating : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RatingID*)objectID;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* score;



@property int32_t scoreValue;
- (int32_t)scoreValue;
- (void)setScoreValue:(int32_t)value_;

//- (BOOL)validateScore:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Area *area;

//- (BOOL)validateArea:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Item *item;

//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;





@end

@interface _Rating (CoreDataGeneratedAccessors)

@end

@interface _Rating (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSNumber*)primitiveScore;
- (void)setPrimitiveScore:(NSNumber*)value;

- (int32_t)primitiveScoreValue;
- (void)setPrimitiveScoreValue:(int32_t)value_;





- (Area*)primitiveArea;
- (void)setPrimitiveArea:(Area*)value;



- (Item*)primitiveItem;
- (void)setPrimitiveItem:(Item*)value;


@end
