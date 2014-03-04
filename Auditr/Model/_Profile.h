// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.h instead.

#import <CoreData/CoreData.h>


extern const struct ProfileAttributes {
	__unsafe_unretained NSString *active;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *parseUserId;
	__unsafe_unretained NSString *profileId;
	__unsafe_unretained NSString *profileImage;
	__unsafe_unretained NSString *profileName;
} ProfileAttributes;

extern const struct ProfileRelationships {
	__unsafe_unretained NSString *entities;
} ProfileRelationships;

extern const struct ProfileFetchedProperties {
} ProfileFetchedProperties;

@class SyncEntity;








@interface ProfileID : NSManagedObjectID {}
@end

@interface _Profile : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProfileID*)objectID;





@property (nonatomic, strong) NSNumber* active;



@property BOOL activeValue;
- (BOOL)activeValue;
- (void)setActiveValue:(BOOL)value_;

//- (BOOL)validateActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* parseUserId;



//- (BOOL)validateParseUserId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* profileId;



//- (BOOL)validateProfileId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* profileImage;



//- (BOOL)validateProfileImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* profileName;



//- (BOOL)validateProfileName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *entities;

- (NSMutableSet*)entitiesSet;





@end

@interface _Profile (CoreDataGeneratedAccessors)

- (void)addEntities:(NSSet*)value_;
- (void)removeEntities:(NSSet*)value_;
- (void)addEntitiesObject:(SyncEntity*)value_;
- (void)removeEntitiesObject:(SyncEntity*)value_;

@end

@interface _Profile (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveActive;
- (void)setPrimitiveActive:(NSNumber*)value;

- (BOOL)primitiveActiveValue;
- (void)setPrimitiveActiveValue:(BOOL)value_;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveParseUserId;
- (void)setPrimitiveParseUserId:(NSString*)value;




- (NSString*)primitiveProfileId;
- (void)setPrimitiveProfileId:(NSString*)value;




- (NSData*)primitiveProfileImage;
- (void)setPrimitiveProfileImage:(NSData*)value;




- (NSString*)primitiveProfileName;
- (void)setPrimitiveProfileName:(NSString*)value;





- (NSMutableSet*)primitiveEntities;
- (void)setPrimitiveEntities:(NSMutableSet*)value;


@end
