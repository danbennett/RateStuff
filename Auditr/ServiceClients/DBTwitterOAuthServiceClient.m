//
//  DBTwitterOAuthServiceClient.m
//  Auditr
//
//  Created by Daniel Bennett on 15/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBTwitterOAuthServiceClient.h"
#import <AFOAuth1Client/AFOAuth1Client.h>
#import <AFOAuth2Client/AFOAuth2Client.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Parse-iOS-SDK/Parse.h>

@interface DBTwitterOAuthServiceClient()

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *apiSecret;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) AFOAuth1Client *client;

@end

@implementation DBTwitterOAuthServiceClient

- (id) initWithBaseUrl: (NSString *) baseUrl apiKey: (NSString *) apiKey apiSecret: (NSString *) apiSecret
{
    self = [super init];
    if (self)
	{
		[PFTwitterUtils initializeWithConsumerKey: apiKey consumerSecret: apiSecret];
		
		self.baseUrl = [NSURL URLWithString: baseUrl];
		self.apiKey = apiKey;
		self.apiSecret = apiSecret;
		self.client = [[AFOAuth1Client alloc] initWithBaseURL: self.baseUrl key: apiKey secret: apiSecret];
    }
    return self;
}

- (RACSignal *) reverseOAuthForAccount: (ACAccount *) account
{
	@weakify(self);
	return [[self requestReverseToken] flattenMap:^RACStream *(NSString *authSignature) {
	
		@strongify(self);
		return [self reverseOAuthWithSignature: authSignature forAccount: account];
		
	}];
}

- (RACSignal *) requestReverseToken
{
	RACSubject *subject = [RACSubject subject];
	
    NSDictionary *params = @{@"x_auth_mode": @"reverse_auth"};
	
	[self.client getPath: @"request_token" parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		NSString *responseString = [[NSString alloc] initWithData: responseObject encoding: NSUTF8StringEncoding];
		if (responseString)
		{
			[subject sendNext: responseString];
			[subject sendCompleted];
		}
		else
		{
			NSError *error = [NSError errorWithDomain: @"uk.co.danbennett" code: 400 userInfo: @{@"user_info" : @"No response string found"}];
			[subject sendError: error];
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		[subject sendError: error];
		
	}];
	
	return subject;
}

- (RACSignal *) reverseOAuthWithSignature: (NSString *) signature forAccount: (ACAccount *) account
{
	RACSubject *subject = [RACSubject subject];
	
	NSDictionary *params = @{ @"x_reverse_auth_target" : self.apiKey,
							  @"x_reverse_auth_parameters" : signature};
	
	NSURL *url = [NSURL URLWithString: @"access_token" relativeToURL: self.baseUrl];
	SLRequest *request = [SLRequest requestForServiceType: SLServiceTypeTwitter requestMethod: SLRequestMethodPOST URL: url parameters: params];
	[request setAccount: account];
	
	[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
		
		if (responseData && !error)
		{
			NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			
			NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
			
			NSArray *components = [responseString componentsSeparatedByString: @"&"];
			
			[components enumerateObjectsUsingBlock:^(NSString *component, NSUInteger idx, BOOL *stop) {
				
				NSArray *keyValue = [component componentsSeparatedByString:@"="];
				if (keyValue.count < 2) *stop = YES;
				
				[dictionary setObject: keyValue[1] forKey: keyValue[0]];
			}];
			
			[subject sendNext: dictionary];
			[subject sendCompleted];
		}
		else
		{
			if (!error)
			{
				error = [NSError errorWithDomain: @"uk.co.danbennett" code: 400 userInfo: @{@"user_info" : @"No token found"}];
			}
			[subject sendError: error];
		}
		
	}];
	
	return subject;
}

@end
