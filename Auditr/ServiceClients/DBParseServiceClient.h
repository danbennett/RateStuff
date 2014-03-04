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

- (id) initWithBaseUrl: (NSString *) baseUrl
		 applicationId: (NSString *) applicationId
				apiKey: (NSString *) apiKey
			apiVersion: (NSNumber *) apiVersion;

- (RACSignal *) linkWithId: (NSString *) twitterId
				screenName: (NSString *) screenName
				 authToken: (NSString *) authToken
		   authTokenSecret: (NSString *) authTokenSecret;

- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;
- (RACSignal *) createClasseOfName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (void) addCreateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (void) addDeleteRequestForClassName: (NSString *) className forUser: (NSString *) userId;
- (void) addUpdateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (RACSignal *) executeBatchRequests;
- (RACSignal *) syncAllUsers;

@end

@interface DBParseServiceClient : AFHTTPClient

- (id) initWithBaseUrl: (NSString *) baseUrl
		 applicationId: (NSString *) applicationId
				apiKey: (NSString *) apiKey
			apiVersion: (NSNumber *) apiVersion;

- (RACSignal *) linkWithId: (NSString *) twitterId
				screenName: (NSString *) screenName
				 authToken: (NSString *) authToken
		   authTokenSecret: (NSString *) authTokenSecret;

- (RACSignal *) pullClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username;
- (RACSignal *) createClasseOfName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (void) addCreateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (void) addDeleteRequestForClassName: (NSString *) className forUser: (NSString *) userId;
- (void) addUpdateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId;
- (RACSignal *) executeBatchRequests;
- (RACSignal *) syncAllUsers;

@end
