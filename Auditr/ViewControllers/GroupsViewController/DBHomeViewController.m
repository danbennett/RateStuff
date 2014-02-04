//
//  DBGroupsViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 09/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBHomeViewController.h"
#import "DBHomeViewModel.h"
#import  <Typhoon/Typhoon.h>
#import "DBGroupService.h"
#import "DBEditGroupViewController.h"

@interface DBHomeViewController ()

@property (nonatomic, strong) DBHomeViewModel *viewModel;

@end

@implementation DBHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	
	id<DBGroupService> groupService = [factory groupService];
	
	self.viewModel = [[DBHomeViewModel alloc] initWithGroupService: groupService];
	
	[self applyBindings];
}

- (void) applyBindings
{
	RAC(self, title) = RACObserve(self.viewModel, title);
}

- (IBAction) burgerButtonTapped: (UIBarButtonItem *)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DBBurgerButtonPressedNotification object: nil];
}

- (IBAction) addNewGroupTapped: (UIButton *) sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DBNewGroupPressedNotification object: nil];
}

@end
