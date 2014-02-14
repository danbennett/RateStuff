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

@interface DBParseServiceClient()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DBParseServiceClient

- (id) initWithBaseUrl: (NSString *) baseUrl applicationId: (NSString *) applicationId apiKey: (NSString *) apiKey
{
	if ([super initWithBaseURL: [NSURL URLWithString: baseUrl]])
	{
		self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.'999Z'"];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		
		[self setDefaultHeader: @"X-Parse-Application-Id" value: applicationId];
		[self setDefaultHeader: @"X-Parse-REST-API-Key" value: apiKey];
		[self setDefaultHeader: @"Accept" value: @"application/json"];
	}
	return self;
}

// TODO: Add user filter.
- (RACSignal *) syncClassesOfName: (NSString *) className updatedAfterDate: (NSDate *) date forUser: (NSString *) username
{
	if (date)
	{
		NSDictionary *params = @{ @"where" : @{
										  @"updatedAt" : @{
												  @"$gte":  @{
														  @"__type": @"Date",
														  @"iso" : [self.dateFormatter stringFromDate: date]
														  }
												  }
										  }
								  };
		
		return [self rac_getPath: [NSString stringWithFormat: @"classes/%@", className] parameters: params];
	}
	return nil;
}

@end
