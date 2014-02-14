//
//  DBSettingsViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBProfileService;
@class DBProfileViewModel;

@interface DBSettingsViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readonly) NSString *twitterUsername;
@property (nonatomic, weak) DBProfileViewModel *profileViewModel;

- (id) initWithTwitterAuthService: (id<DBProfileService>) profileService;

@end
