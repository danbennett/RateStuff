//
//  DBTwitterAuthService.h
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PFUser;
@class ACAccount;
@protocol DBTwitterServiceClient;

@protocol DBTwitterAuthService <NSObject>

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient;
- (RACSignal *) login;
- (void) saveUser: (ACAccount *) user;
- (RACSignal *) loadProfileImageForUser: (ACAccount *) user;

- (ACAccount *) currentUser;

@end

@interface DBTwitterAuthService : NSObject

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient;
- (RACSignal *) login;
- (void) saveUser: (ACAccount *) user;
- (RACSignal *) loadProfileImageForUser: (ACAccount *) user;

- (ACAccount *) currentUser;

@end
