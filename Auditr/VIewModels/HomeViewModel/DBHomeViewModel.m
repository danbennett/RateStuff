//
//  DBHomeViewModel.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBHomeViewModel.h"
#import "DBGroupService.h"
#import "DBGroupViewModel.h"
#import "DBTwitterAuthService.h"
#import <Parse-iOS-SDK/Parse.h>

@interface DBHomeViewModel()

@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@property (nonatomic, assign) id<DBGroupService> groupService;
@property (nonatomic, assign) id<DBTwitterAuthService> twitterService;

@end

@implementation DBHomeViewModel

- (id) initWithGroupService: (id<DBGroupService>) groupService
				authService: (id<DBTwitterAuthService>) twitterAuthService
{
    self = [super init];
    if (self)
	{
		self.groupService = groupService;
		self.twitterService = twitterAuthService;
		
		[self createBindings];
    }
    return self;
}

- (DBGroupViewModel *) newGroupViewModel
{
	Group *group = [self.groupService createBlankGroup];
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	
	id<DBGroupService> groupService = [factory groupService];
	id<DBAreaService> areaService = [factory areaService];
	
	DBGroupViewModel *viewModel = [[DBGroupViewModel alloc] initWithGroupService: groupService areaService: areaService];
	viewModel.group = group;
	
	return viewModel;
}

- (void) createBindings
{
	self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		return [self login];
	}];
}

- (RACSignal *) login
{
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		
		[self.twitterService loginWithCompletion:^(BOOL success, NSError *error) {
			
			if (success)
			{
				[subscriber sendNext: [NSNull null]];
				[subscriber sendCompleted];
			}
			else
			{
				[subscriber sendError: error];
			}
			
		}];
		return nil;
	}];
}

@end
