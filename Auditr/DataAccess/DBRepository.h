//
//  DBRepository.h
//  Auditr
//
//  Created by Daniel Bennett on 10/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBRepository <NSObject>

- (id) createEntity;
- (NSArray *) getAll;
- (BOOL) saveEntity:(id) entity;
- (void) save:(id) entity withCompletion: (void (^)(BOOL success, NSError *error)) completionHandler;
- (NSArray *) getAllByAttribute: (NSString *) attribute value: (id) value;
- (void) deleteEntity: (id) entity;
- (void) insertObject: (id) object atKey: (NSString *) key onEntity: (id) entity;
- (void) addObject: (id) object forKey: (NSString *) key onEntity: (id) entity;


@end
