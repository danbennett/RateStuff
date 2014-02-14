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
#import "DBProfileService.h"
#import "DBParseService.h"
// Repos.
#import "DBGroupCoreDataRepository.h"
#import "DBAreaCoreDataRepository.h"
#import "DBProfileCoreDataRepository.h"
// Service clients.
#import "DBTwitterServiceClient.h"
#import "DBParseServiceClient.h"
// Settings.
#import "DBTwitterSettings.h"
#import "DBParseSettings.h"

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

- (id) profileService
{
	return [TyphoonDefinition withClass: [DBProfileService class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithServiceClient:profileRepository:);
		[initializer injectWithDefinition: [self twitterServiceClient]];
		[initializer injectWithDefinition: [self profileRepository]];
		
	} properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

- (id) parseService
{
	return [TyphoonDefinition withClass: [DBParseService class] initialization:^(TyphoonInitializer *initializer) {
		
		initializer.selector = @selector(initWithServiceClient:groupRepository:);
		[initializer injectWithDefinition: [self parseServiceClient]];
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

- (id) areaRepository
{
	return [TyphoonDefinition withClass: [DBAreaCoreDataRepository class] properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

- (id) profileRepository
{
	return [TyphoonDefinition withClass: [DBProfileCoreDataRepository class] properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

#pragma mark - service client

- (id) twitterServiceClient
{
	return [TyphoonDefinition withClass: [DBTwitterServiceClient class] initialization:^(TyphoonInitializer *initializer) {
		
		DBTwitterSettings *settings = [DBTwitterSettings sharedInstance];
		
		initializer.selector = @selector(initWithBaseUrl:);
		[initializer injectWithObjectInstance: settings.baseUrl];
		
	} properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

- (id) parseServiceClient
{
	return [TyphoonDefinition withClass: [DBParseServiceClient class] initialization:^(TyphoonInitializer *initializer) {
		
		DBParseSettings *settings = [DBParseSettings sharedInstance];
		
		initializer.selector = @selector(initWithBaseUrl:applicationId:apiKey:);
		[initializer injectWithObjectInstance: settings.baseUrl];
		[initializer injectWithObjectInstance: settings.applicationId];
		[initializer injectWithObjectInstance: settings.apiKey];
		
	} properties:^(TyphoonDefinition *definition) {
		
		[definition setScope: TyphoonScopeSingleton];
		
	}];
}

@end
