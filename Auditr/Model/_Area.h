// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Area.h instead.

#import <CoreData/CoreData.h>


extern const struct AreaAttributes {
	__unsafe_unretained NSString *areaName;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *score;
} AreaAttributes;

extern const struct AreaRelationships {
	__unsafe_unretained NSString *group;
} AreaRelationships;

extern const struct AreaFetchedProperties {
} AreaFetchedProperties;

@class Group;





@interface AreaID : NSManagedObjectID {}
@end

@interface _Area : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AreaID*)objectID;





@property (nonatomic, strong) NSString* areaName;



//- (BOOL)validateAreaName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* id;



//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* score;



@property int32_t scoreValue;
- (int32_t)scoreValue;
- (void)setScoreValue:(int32_t)value_;

//- (BOOL)validateScore:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Group *group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;





@end

@interface _Area (CoreDataGeneratedAccessors)

@end

@interface _Area (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAreaName;
- (void)setPrimitiveAreaName:(NSString*)value;




- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;




- (NSNumber*)primitiveScore;
- (void)setPrimitiveScore:(NSNumber*)value;

- (int32_t)primitiveScoreValue;
- (void)setPrimitiveScoreValue:(int32_t)value_;





- (Group*)primitiveGroup;
- (void)setPrimitiveGroup:(Group*)value;


@end
