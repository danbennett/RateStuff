//
//  DBAssembly.m
//  Auditr
//
//  Created by Daniel Bennett on 10/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBAssembly.h"
// ViewModels.
#import "DBBaseViewModel.h"
#import "DBHomeViewModel.h"
#import "DBGroupViewModel.h"
#import "DBAreaViewModel.h"
// Services.
#import "DBGroupService.h"
#import "DBAreaService.h"
// Repos.
#import "DBGroupCoreDataRepository.h"
#import "DBAreaCoreDataRepository.h"

@implementation DBAssembly

#pragma mark - view models

- (id) baseViewModel
{
	return [TyphoonDefinition withClass: [DBBaseViewModel class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupService:);
		[initializer injectWithDefinition: [self groupService]];
		
	}];
}

- (id) homeViewModel
{
	return [TyphoonDefinition withClass: [DBHomeViewModel class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupService:);
		[initializer injectWithDefinition: [self groupService]];
		
	}];
}

- (id) groupViewModel
{
	return [TyphoonDefinition withClass: [DBGroupViewModel class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupService:areaService:);
		[initializer injectWithDefinition: [self groupService]];
		[initializer injectWithDefinition: [self areaService]];
		
	}];
}

- (id) areaViewModel
{
	return [TyphoonDefinition withClass: [DBAreaViewModel class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithAreaService:);
		[initializer injectWithDefinition: [self areaService]];
		
	}];
}

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
