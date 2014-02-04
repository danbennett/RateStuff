//
//  DBAssembly.m
//  Auditr
//
//  Created by Daniel Bennett on 10/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBAssembly.h"
// Services.
#import "DBGroupService.h"
#import "DBAreaService.h"
// Repos.
#import "DBGroupCoreDataRepository.h"
#import "DBAreaCoreDataRepository.h"

@implementation DBAssembly

#pragma mark - services

- (id) groupService
{
	return [TyphoonDefinition withClass: [DBGroupService class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupRepository:areaRepository:);
		[initializer injectWithDefinition: [self groupRepository]];
		[initializer injectWithDefinition: [self areaRepository]];
		
	} properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

- (id) areaService
{
	return [TyphoonDefinition withClass: [DBAreaService class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithAreaRepository:);
		[initializer injectWithDefinition: [self areaRepository]];
		
	} properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

#pragma mark - repos

- (id) groupRepository
{
	return [TyphoonDefinition withClass: [DBGroupCoreDataRepository class] properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

- (id) areaRepository
{
	return [TyphoonDefinition withClass: [DBAreaCoreDataRepository class] properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

@end
