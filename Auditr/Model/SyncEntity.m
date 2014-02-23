#import "SyncEntity.h"


@interface SyncEntity ()

// Private interface goes here.

@end


@implementation SyncEntity

- (NSDictionary *) asDictionary
{
	@throw [NSException exceptionWithName: @"asDictionaryAbstractMessage" reason: @"You have not overridden an abstract method" userInfo: nil];
}

@end
