//
//  DBParseServiceClient.h
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol DBParseServiceClient <NSObject>

- (id) initWithBaseUrl: (NSString *) baseUrl applicationId: (NSString *) applicationId apiKey: (NSString *) apiKey;
- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;

@end

@interface DBParseServiceClient : AFHTTPClient

- (id) initWithBaseUrl: (NSString *) baseUrl applicationId: (NSString *) applicationId apiKey: (NSString *) apiKey;
- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;

@end
