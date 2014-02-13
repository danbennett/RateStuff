//
//  DBSettingsViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DBTwitterAuthService;

@interface DBSettingsViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *chooseTwitterAccountCommand;
@property (nonatomic, strong, readonly) NSString *twitterUsername;

- (id) initWithTwitterAuthService: (id<DBTwitterAuthService>) twitterAuthService;

@end
