//
//  DBTwitterServiceClient.m
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterServiceClient.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface DBTwitterServiceClient()

@property (nonatomic, strong) NSURL *baseUrl;

@end

@implementation DBTwitterServiceClient

- (id) initWithBaseUrl: (NSString *) baseUrl
{
    self = [super init];
    if (self)
	{
		self.baseUrl = [NSURL URLWithString: baseUrl];
    }
    return self;
}

- (RACSignal *) loadProfileForUser: (ACAccount *) user
{
	RACSubject *subject = [RACSubject subject];
	
	NSURL *url = [NSURL URLWithString:@"users/profile_image" relativeToURL: self.baseUrl];
		
	NSDictionary *params = @{@"screen_name" : user.username,
                             @"size" : @"bigger"};

	SLRequest *request = [SLRequest requestForServiceType: SLServiceTypeTwitter requestMethod: SLRequestMethodGET URL: url parameters: params];
	[request setAccount: user];
	
	[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		
		if(responseData && !error)
		{
			[subject sendNext: [UIImage imageWithData: responseData]];
			[subject sendCompleted];
		}
		else
		{
			[subject sendError: error];
		}
		
	}];

	return subject;
}

@end
