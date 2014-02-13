//
//  DBHTTPClient.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBHTTPClient.h"

@implementation DBHTTPClient

- (id) initWithBaseUrl: (NSString *) baseUrl
{
	if ([super initWithBaseURL: [NSURL URLWithString: baseUrl]])
	{
		[self setDefaultHeader: @"Accept" value: @"application/json"];
	}
	return self;
}

@end
