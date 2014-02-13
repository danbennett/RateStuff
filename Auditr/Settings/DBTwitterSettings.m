//
//  DBTwitterSettings.m
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterSettings.h"

static NSString *const DBTwitterBaseUrlKey = @"BaseUrl";

@interface DBTwitterSettings()

@property (nonatomic, strong, readwrite) NSString *baseUrl;

@end

@implementation DBTwitterSettings

+ (id) sharedInstance
{
	static DBTwitterSettings *instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString *filePath = [[NSBundle mainBundle] pathForResource: @"TwitterSettings" ofType: @"plist"];
		instance = [[DBTwitterSettings alloc] initWithFilePath: filePath]; 
	});
	return instance;
}

- (id) initWithFilePath: (NSString *) filePath
{
    self = [super init];
    if (self)
	{
        NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: filePath];
		
		self.baseUrl = settings[DBTwitterBaseUrlKey];
    }
    return self;
}

@end
