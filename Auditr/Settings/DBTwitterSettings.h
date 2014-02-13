//
//  DBTwitterSettings.h
//  Auditr
//
//  Created by Daniel Bennett on 10/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTwitterSettings : NSObject

+ (id) sharedInstance;

@property (nonatomic, strong, readonly) NSString *baseUrl;

@end
