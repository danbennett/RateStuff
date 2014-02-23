// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SyncEntity.h instead.

#import <CoreData/CoreData.h>


extern const struct SyncEntityAttributes {
	__unsafe_unretained NSString *syncId;
	__unsafe_unretained NSString *syncStatus;
} SyncEntityAttributes;

extern const struct SyncEntityRelationships {
} SyncEntityRelationships;

extern const struct SyncEntityFetchedProperties {
} SyncEntityFetchedProperties;





@interface SyncEntityID : NSManagedObjectID {}
@end

@interface _SyncEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SyncEntityID*)objectID;





@property (nonatomic, strong) NSString* syncId;



//- (BOOL)validateSyncId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* syncStatus;



@property int32_t syncStatusValue;
- (int32_t)syncStatusValue;
- (void)setSyncStatusValue:(int32_t)value_;

//- (BOOL)validateSyncStatus:(id*)value_ error:(NSError**)error_;






@end

@interface _SyncEntity (CoreDataGeneratedAccessors)

@end

@interface _SyncEntity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveSyncId;
- (void)setPrimitiveSyncId:(NSString*)value;




- (NSNumber*)primitiveSyncStatus;
- (void)setPrimitiveSyncStatus:(NSNumber*)value;

- (int32_t)primitiveSyncStatusValue;
- (void)setPrimitiveSyncStatusValue:(int32_t)value_;




@end
