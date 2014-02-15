//
//  DBTwitterServiceClient.h
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ACAccount;

@protocol DBTwitterServiceClient <NSObject>

@required
- (id) initWithBaseUrl: (NSString *) baseUrl;
- (RACSignal *) loadProfileImageForUser: (ACAccount *) user;

@end

@interface DBTwitterServiceClient : NSObject

- (id) initWithBaseUrl: (NSString *) baseUrl;
- (RACSignal *) loadProfileImageForUser: (ACAccount *) user;

@end
