//
//  DBAssembly.m
//  Auditr
//
//  Created by Daniel Bennett on 10/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBAssembly.h"
#import "DBBaseViewModel.h"
#import "DBGroupCoreDataRepository.h"
#import "DBGroupService.h"

@implementation DBAssembly

#pragma mark - view models

- (id) baseViewModel
{
	return [TyphoonDefinition withClass: [DBBaseViewModel class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupService:);
		[initializer injectWithDefinition: [self groupService]];
		
	}];
}

#pragma mark - services

- (id) groupService
{
	return [TyphoonDefinition withClass: [DBGroupService class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithGroupRepository:);
		[initializer injectWithDefinition: [self groupRepository]];
		
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

@end
