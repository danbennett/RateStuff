//
//  DBCoreDataManager.h
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCoreDataManager : NSObject

+ (id) sharedInstance;
- (void) setupStack;

@end
