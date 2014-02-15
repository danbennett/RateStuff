//
//  DBTwitterSettings.m
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterSettings.h"

static NSString *const DBTwitterBaseUrlKey = @"BaseUrl";
static NSString *const DBTwitterOAuthBaseUrlKey = @"OAuthBaseUrl";
static NSString *const DBTwitterApiSecretKey = @"apiSecret";
static NSString *const DBTwitterApiKeyKey = @"apiKey";

@interface DBTwitterSettings()

@property (nonatomic, strong, readwrite) NSString *baseUrl;
@property (nonatomic, strong, readwrite) NSString *OAuthBaseUrl;
@property (nonatomic, strong, readwrite) NSString *apiKey;
@property (nonatomic, strong, readwrite) NSString *apiSecret;

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
		self.OAuthBaseUrl = settings[DBTwitterOAuthBaseUrlKey];
		self.apiKey = settings[DBTwitterApiKeyKey];
		self.apiSecret = settings[DBTwitterApiSecretKey];
    }
    return self;
}

@end
