//
//  DBTwitterAuthService.h
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Profile;
@class ACAccount;
@protocol DBTwitterServiceClient;
@protocol DBTwitterOAuthServiceClient;
@protocol DBProfileRepository;

@protocol DBProfileService <NSObject>

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		  oAuthServiceClient: (id<DBTwitterOAuthServiceClient>) oAuthServiceClient
		   profileRepository: (id<DBProfileRepository>) repository;

- (RACSignal *) loadTwitterAccounts;
- (Profile *) loginWithAccount: (ACAccount *) account;
- (RACSignal *) loadProfileImageForProfile: (Profile *) profile;
- (RACSignal *) reverseOAuthForProfile: (Profile *) profile;
- (Profile *) currentProfile;
- (void) activateProfile: (Profile *) newProfile;
- (void) deleteProfile: (Profile *) profile;

@end

extern NSString const *DBTwitterResponseUserIdKey;
extern NSString const *DBTwitterResponseScreenNameKey;
extern NSString const *DBTwitterResponseOAuthTokenSecretKey;
extern NSString const *DBTwitterResponseOAuthTokenKey;

@interface DBProfileService : NSObject

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		  oAuthServiceClient: (id<DBTwitterOAuthServiceClient>) oAuthServiceClient
		   profileRepository: (id<DBProfileRepository>) repository;

- (RACSignal *) loadTwitterAccounts;
- (Profile *) loginWithAccount: (ACAccount *) account;
- (RACSignal *) loadProfileImageForProfile: (Profile *) profile;
- (RACSignal *) reverseOAuthForProfile: (Profile *) profile;
- (Profile *) currentProfile;
- (void) activateProfile: (Profile *) newProfile;
- (void) deleteProfile: (Profile *) profile;

@end
