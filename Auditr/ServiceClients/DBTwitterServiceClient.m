//
//  DBTwitterServiceClient.m
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterServiceClient.h"
#import <Twitter/Twitter.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Accounts/Accounts.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPClient+RACSupport.h>
#import <AFNetworking-RACExtensions/AFURLConnectionOperation+RACSupport.h>

@interface DBTwitterServiceClient()

@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) AFHTTPClient *httpClient;

@end

static NSString *const DBTwitterProfileImageKey = @"profile_image_url";

@implementation DBTwitterServiceClient

- (id) initWithBaseUrl: (NSString *) baseUrl
{
    self = [super init];
    if (self)
	{
		self.baseUrl = [NSURL URLWithString: baseUrl];
		self.httpClient = [[AFHTTPClient alloc] initWithBaseURL: self.baseUrl];
    }
    return self;
}

- (RACSignal *) loadProfileImageForUser: (ACAccount *) user
{
	@weakify(self);
		
	return [[self loadProfileInfoForUser: user] flattenMap:^RACStream *(NSString *profileUrl) {
		@strongify(self);
		return [self requestImageAtPath: profileUrl];
	}];
}

- (RACSignal *) loadProfileInfoForUser: (ACAccount *) user
{
	RACSubject *subject = [RACSubject subject];
	
	NSURL *url = [NSURL URLWithString:@"users/show.json" relativeToURL: self.baseUrl];
		
	NSDictionary *params = @{@"screen_name" : user.username,
                             @"user_id " : user.username };

	SLRequest *request = [SLRequest requestForServiceType: SLServiceTypeTwitter requestMethod: SLRequestMethodGET URL: url parameters: params];
	[request setAccount: user];
	
	[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		
		BOOL succesful = NO;
		if(responseData && !error)
		{
			NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableLeaves error: &error];
			if (responseDictionary)
			{
				if ([responseDictionary objectForKey: DBTwitterProfileImageKey] != [NSNull null])
				{
					succesful = YES;
					NSString *imageUrl = [responseDictionary valueForKey:DBTwitterProfileImageKey];

					NSString *lastComponent = [imageUrl lastPathComponent];
					NSScanner *scanner = [NSScanner scannerWithString: lastComponent];
					NSString *firstBit = nil;
					NSString *middleBit = nil;
					[scanner scanUpToString: @"_" intoString: &firstBit];
					[scanner scanUpToString: @"." intoString: &middleBit];
					
					NSString *fileName = [NSString stringWithFormat: @"%@.%@", firstBit, [lastComponent pathExtension]];
					
					NSString *modifiedUrl = [imageUrl stringByReplacingOccurrencesOfString: lastComponent withString: fileName];
					
					[subject sendNext: modifiedUrl];
					[subject sendCompleted];
				}
			}
		}
		
		if (!succesful)
		{
			[subject sendError: error];
		}
		
	}];

	return subject;
}

- (RACSignal *) requestImageAtPath: (NSString *) imagePath
{
	RACSubject *subject = [RACSubject subject];
	
	NSURL *url = [NSURL URLWithString: imagePath relativeToURL: self.baseUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL: url];

	[[[AFImageRequestOperation rac_startImageRequestOperationWithRequest: request] map:^id(RACTuple *values) {
		return [values first];
	}] subscribeNext:^(UIImage *image) {
		[subject sendNext:image];
	}];
	
	return subject;
}

@end
