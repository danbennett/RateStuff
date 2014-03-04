//
//  DBParseServiceClient.m
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBParseServiceClient.h"
#import <Parse-iOS-SDK/Parse.h>
#import <AFNetworking-RACExtensions/AFHTTPClient+RACSupport.h>
#import <AFNetworking-RACExtensions/AFURLConnectionOperation+RACSupport.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBParseServiceClient()

@property (nonatomic, strong) NSNumber *apiVersion;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableArray *requests;

@end

static NSString *const DBParseUsersResultKey = @"results";

@implementation DBParseServiceClient

- (id) initWithBaseUrl: (NSString *) baseUrl
		 applicationId: (NSString *) applicationId
				apiKey: (NSString *) apiKey
			apiVersion: (NSNumber *) apiVersion
{
	if ([super initWithBaseURL: [NSURL URLWithString: baseUrl]])
	{
		self.requests = [NSMutableArray array];
		self.apiVersion = apiVersion;
		
		self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

		[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
		[self setParameterEncoding:AFJSONParameterEncoding];
		[self setDefaultHeader: @"X-Parse-Application-Id" value: applicationId];
		[self setDefaultHeader: @"X-Parse-REST-API-Key" value: apiKey];
		[self setDefaultHeader: @"Accept" value: @"application/json"];
	}
	return self;
}

- (RACSignal *) linkWithId: (NSString *) twitterId
				screenName: (NSString *) screenName
				 authToken: (NSString *) authToken
		   authTokenSecret: (NSString *) authTokenSecret
{
	RACSubject *subject = [RACSubject subject];
	
	[PFTwitterUtils logInWithTwitterId: twitterId
							screenName: screenName
							 authToken: authToken
					   authTokenSecret: authTokenSecret
								 block:^(PFUser *user, NSError *error) {
									 
									 if(user && !error)
									 {
										 [subject sendNext: user.username];
										 [subject sendCompleted];
									 }
									 else
									 {
										 [subject sendError: error];
									 }
		
								 }];
	return subject;
}

- (RACSignal *) syncAllUsers
{
	RACSubject *subject = [RACSubject subject];
	
	[[self rac_getPath: @"users" parameters: nil] subscribeNext:^(RACTuple *tuple) {
		NSDictionary *responseDictionary = [tuple second];
		NSError *error = nil;
		BOOL successful = NO;
		
		if (responseDictionary)
		{
			if ([responseDictionary valueForKey: DBParseUsersResultKey])
			{
				if ([responseDictionary valueForKey: DBParseUsersResultKey] != [NSNull null])
				{
					successful = YES;
					NSArray *users = [responseDictionary valueForKey: DBParseUsersResultKey];
					NSArray *usernames = [users valueForKeyPath: @"username"];
					[subject sendNext: usernames];
					[subject sendCompleted];
				}
			}
		}
		
		if (!successful)
		{
			[subject sendError: error];
		}
	} error:^(NSError *error) {
		[subject sendError: error];
	}];
	
	return subject;
}

// TODO: Add user filter.
- (RACSignal *) pullClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username
{
	if (!date)
	{
		date = [NSDate date];
	}

	NSString *jsonString = [NSString
							stringWithFormat:@"{\"updatedAt\":{\"$gte\":{\"__type\":\"Date\",\"iso\":\"%@\"}}}", [self.dateFormatter stringFromDate: date]];
	
	NSDictionary *params = [NSDictionary dictionaryWithObject:jsonString forKey:@"where"];
	
	RACSubject *subject = [RACSubject subject];
		
	[[self rac_getPath: [NSString stringWithFormat: @"classes/%@", className] parameters: params] subscribeNext:^(RACTuple *tuple) {
		
		[subject sendNext: [tuple second]];
		[subject sendCompleted];
		
	} error:^(NSError *error) {
		
		[subject sendError: error];
		
	}];
	
	return subject;
}

- (RACSignal *) createClasseOfName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId
{
	return [self rac_postPath: [NSString stringWithFormat: @"classes/%@", className] parameters: values];
}

- (void) addCreateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId
{
	NSMutableDictionary *withUser = [values mutableCopy];
	[withUser setObject: userId forKey: @"User"];
	
	NSString *batchPath = [NSString stringWithFormat: @"/%@/classes/%%@", self.apiVersion];
	NSDictionary *request =
	@{@"method": @"POST",
	  @"path": [NSString stringWithFormat: batchPath, className],
	  @"body": withUser};
	
	[self.requests addObject: request];
}

- (void) addDeleteRequestForClassName: (NSString *) className forUser: (NSString *) userId
{
	NSString *batchPath = [NSString stringWithFormat: @"/%@/classes/%%@", self.apiVersion];
	NSDictionary *request =
	@{@"method": @"DELETE",
	  @"path": [NSString stringWithFormat: batchPath, className]};
	
	[self.requests addObject: request];
}

- (void) addUpdateRequestForClassName: (NSString *) className withValues: (NSDictionary *) values forUser: (NSString *) userId
{
	NSMutableDictionary *withUser = [values mutableCopy];
	[withUser setObject: userId forKey: @"User"];
	
	NSString *batchPath = [NSString stringWithFormat: @"/%@/classes/%%@", self.apiVersion];
	NSDictionary *request =
	@{@"method": @"PUT",
	  @"path": [NSString stringWithFormat: batchPath, className],
	  @"body": withUser};
	
	[self.requests addObject: request];
	
}

- (RACSignal *) executeBatchRequests
{
	NSDictionary *params = @{@"requests": self.requests};
	RACSubject *subject = [RACSubject subject];
	
	@weakify(self);
	[[self rac_postPath: @"batch" parameters: params] subscribeNext:^(id x) {
		@strongify(self);
		[subject sendNext: [NSNull null]];
		[subject sendCompleted];
		self.requests = [NSMutableArray array];
	} error:^(NSError *error) {
		@strongify(self);
		[subject sendError: error];
		self.requests = [NSMutableArray array];
	}];
	
	return subject;
}

@end
