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

- (Area *) createArea
{
	Area *area = [self.areaRepository createEntity];
	area.syncId = [NSString uuid];
	return area;
}

- (void) deleteArea: (Area *) area
{
	[self.areaRepository deleteEntity: area];
}

@end
