#import "_SyncEntity.h"

typedef enum {
	DBSyncStatusSynced = 0,
	DBSyncStatusCreated = 1,
	DBSyncStatusEdited = 2
} DBSyncStatus;

@interface SyncEntity : _SyncEntity {}

- (NSDictionary *) asDictionary;

@end
