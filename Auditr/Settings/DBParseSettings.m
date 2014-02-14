//
//  DBParseSettings.m
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBParseSettings.h"

@interface DBParseSettings()

@property (nonatomic, strong, readwrite) NSString *baseUrl;
@property (nonatomic, strong, readwrite) NSString *applicationId;
@property (nonatomic, strong, readwrite) NSString *apiKey;

@end

static NSString *const DBParseBaseUrlKey = @"baseUrl";
static NSString *const DBParseApplicationIdKey = @"appId";
static NSString *const DBParseApiKeyKey = @"apiKey";

@implementation DBParseSettings

+ (id) sharedInstance
{
	static DBParseSettings *instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString *filePath = [[NSBundle mainBundle] pathForResource: @"ParseSettings" ofType: @"plist"];
		instance = [[DBParseSettings alloc] initWithFilePath: filePath];
	});
	return instance;
}

- (id) initWithFilePath: (NSString *) filePath
{
    self = [super init];
    if (self)
	{
        NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: filePath];
		
		self.baseUrl = settings[DBParseBaseUrlKey];
		self.applicationId = settings[DBParseApplicationIdKey];
		self.apiKey = settings[DBParseApiKeyKey];
    }
    return self;
}

@end
