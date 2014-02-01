// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Profile.h instead.

#import <CoreData/CoreData.h>


extern const struct ProfileAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *profileName;
} ProfileAttributes;

extern const struct ProfileRelationships {
	__unsafe_unretained NSString *groups;
} ProfileRelationships;

extern const struct ProfileFetchedProperties {
} ProfileFetchedProperties;

@class Group;




@interface ProfileID : NSManagedObjectID {}
@end

@interface _Profile : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProfileID*)objectID;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* profileName;



//- (BOOL)validateProfileName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *groups;

- (NSMutableSet*)groupsSet;





@end

@interface _Profile (CoreDataGeneratedAccessors)

- (void)addGroups:(NSSet*)value_;
- (void)removeGroups:(NSSet*)value_;
- (void)addGroupsObject:(Group*)value_;
- (void)removeGroupsObject:(Group*)value_;

@end

@interface _Profile (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveProfileName;
- (void)setPrimitiveProfileName:(NSString*)value;





- (NSMutableSet*)primitiveGroups;
- (void)setPrimitiveGroups:(NSMutableSet*)value;


@end
