//
//  DBParseSettings.h
//  Auditr
//
//  Created by Daniel Bennett on 14/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBParseSettings : NSObject

@property (nonatomic, strong, readonly) NSString *baseUrl;
@property (nonatomic, strong, readonly) NSString *applicationId;
@property (nonatomic, strong, readonly) NSString *clientKey;
@property (nonatomic, strong, readonly) NSString *apiKey;
@property (nonatomic, strong, readonly) NSNumber *apiVersion;

+ (id) sharedInstance;

@end
