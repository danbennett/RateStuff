//
//  DBProfileViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 13/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Profile;
@protocol DBProfileService;
@protocol DBParseService;

@interface DBProfileViewModel : NSObject

- (id) initWithProfileService: (id<DBProfileService>) profileService parseService: (id<DBParseService>) parseService;
- (void) deleteProfile;
- (void) activateProfileWithUserId: (NSString *) userId;

@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong, readonly) NSString *profileName;
@property (nonatomic, strong, readonly) UIImage *profileImage;
@property (nonatomic, strong, readonly) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readonly) RACCommand *loginWithAccountCommand;

@end
