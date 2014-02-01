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

@interface DBHomeViewController ()

@property (nonatomic, strong) DBHomeViewModel *viewModel;

@end

@implementation DBHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	self.viewModel = (DBHomeViewModel *)[factory homeViewModel];
	
	[self styleNavBar];
	[self applyBindings];
}

- (void) styleNavBar
{
	UINavigationBar *navBar = self.navigationController.navigationBar;
	
	[self.navigationController.navigationBar setTranslucent: NO];
	[self.navigationController.navigationBar setTintColor: [UIColor blueColor]];
}

- (void) applyBindings
{
	RAC(self, title) = RACObserve(self.viewModel, title);
}

- (IBAction) burgerButtonTapped: (UIBarButtonItem *)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DBBurgerButtonPressedNotification object: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
