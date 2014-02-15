//
//  DBTwitterOAuthServiceClient.h
//  Auditr
//
//  Created by Daniel Bennett on 15/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACAccount;

@protocol DBTwitterOAuthServiceClient <NSObject>

- (id) initWithBaseUrl: (NSString *) baseUrl apiKey: (NSString *) apiKey apiSecret: (NSString *) apiSecret;
- (RACSignal *) reverseOAuthForAccount: (ACAccount *) account;

@end

@interface DBTwitterOAuthServiceClient : NSObject

- (id) initWithBaseUrl: (NSString *) baseUrl apiKey: (NSString *) apiKey apiSecret: (NSString *) apiSecret;
- (RACSignal *) reverseOAuthForAccount: (ACAccount *) account;

@end
