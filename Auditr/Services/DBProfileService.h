//
//  DBTwitterAuthService.h
//  Auditr
//
//  Created by Daniel Bennett on 08/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Profile;
@protocol DBTwitterServiceClient;
@protocol DBProfileRepository;

@protocol DBProfileService <NSObject>

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		   profileRepository: (id<DBProfileRepository>) repository;

- (RACSignal *) login;
- (RACSignal *) loadProfileImageForProfile: (Profile *) profile;
- (Profile *) currentProfile;

@end

@interface DBProfileService : NSObject

- (id) initWithServiceClient: (id<DBTwitterServiceClient>) serviceClient
		   profileRepository: (id<DBProfileRepository>) repository;

- (RACSignal *) login;
- (RACSignal *) loadProfileImageForProfile: (Profile *) profile;
- (Profile *) currentProfile;

@end
