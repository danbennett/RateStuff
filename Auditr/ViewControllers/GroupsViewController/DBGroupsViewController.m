//
//  DBGroupsViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 09/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBGroupsViewController.h"

@interface DBGroupsViewController ()

@end

@implementation DBGroupsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Groups";
	
	[self.navigationController.navigationBar setTranslucent: YES];
	[self.navigationController.navigationBar setTintColor: [UIColor blueColor]];
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
