//
//  DBGroupViewModel.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;

@interface DBGroupViewModel : NSObject

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) RACSignal *valid;

- (id) initWithGroup: (Group *) group;

@end
