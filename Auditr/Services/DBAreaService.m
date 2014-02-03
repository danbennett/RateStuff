//
//  DBAreaService.m
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaService.h"
#import "DBAreaRepository.h"
#import "Area.h"
#import "NSString+Extensions.h"

@interface DBAreaService()

@property (nonatomic, assign) id<DBAreaRepository> areaRepository;

@end

@implementation DBAreaService

- (id) initWithAreaRepository: (id<DBAreaRepository>) areaRepository
{
    self = [super init];
    if (self)
	{
		self.areaRepository = areaRepository;
    }
    return self;
}

- (Area *) createAreaWithName: (NSString *) areaName
{
	Area *area = [self.areaRepository createEntity];
	area.id = [NSString uuid];
	[area setValue: areaName forKey: @"areaName"];
	return area;
}

@end
