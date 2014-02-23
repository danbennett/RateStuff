#import "Group.h"


@interface Group ()

// Private interface goes here.

@end


@implementation Group

- (NSDictionary *) asDictionary
{
	return @{@"groupName": self.groupName,
			 @"groupDescription": self.groupDescription};
}

@end
