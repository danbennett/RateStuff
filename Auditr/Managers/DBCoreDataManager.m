//
//  DBCoreDataManager.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBCoreDataManager.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface DBCoreDataManager()

@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;

@end

@implementation DBCoreDataManager

+ (id) sharedInstance
{
	static DBCoreDataManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[DBCoreDataManager alloc] init];
	});
	return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self)
	{
        [self setupCoordinator];
    }
    return self;
}

- (void) setupCoordinator
{
	NSManagedObjectModel *model = [NSManagedObjectModel MR_defaultManagedObjectModel];
	self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
}

- (void) setupStack
{
	NSMutableDictionary *sqliteOptions = [NSMutableDictionary dictionary];
    [sqliteOptions setObject:@"WAL" forKey:@"journal_mode"];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
							 NSFileProtectionComplete, NSFileProtectionKey,
							 sqliteOptions, NSSQLitePragmasOption,
							 nil];

	[self.coordinator MR_addSqliteStoreNamed: [MagicalRecord defaultStoreName] withOptions: options];
	[NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator: self.coordinator];
	
	[NSManagedObjectContext MR_initializeDefaultContextWithCoordinator: self.coordinator];
}

@end
