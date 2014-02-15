//
//  DBParseServiceClient.h
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "AFHTTPClient.h"
@class PFUser;

@protocol DBParseServiceClient <NSObject>

- (id) initWithBaseUrl: (NSString *) baseUrl applicationId: (NSString *) applicationId apiKey: (NSString *) apiKey;

- (RACSignal *) linkUser: (PFUser *) user
				  withId: (NSString *) twitterId
			  screenName: (NSString *) screenName
			   authToken: (NSString *) authToken
		 authTokenSecret: (NSString *) authTokenSecret;
- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;
- (RACSignal *) syncAllUsers;

@end

@interface DBParseServiceClient : AFHTTPClient

- (id) initWithBaseUrl: (NSString *) baseUrl applicationId: (NSString *) applicationId apiKey: (NSString *) apiKey;

- (RACSignal *) linkUser: (PFUser *) user
				  withId: (NSString *) twitterId
			  screenName: (NSString *) screenName
			   authToken: (NSString *) authToken
		 authTokenSecret: (NSString *) authTokenSecret;
- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;
- (RACSignal *) syncAllUsers;

@end
