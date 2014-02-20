//
//  DBGroupsViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 09/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBHomeViewController.h"
#import "DBSettingsViewController.h"
#import "DBHomeViewModel.h"
#import "DBProfileViewModel.h"
#import "DBGroupService.h"
#import "DBEditGroupViewController.h"
#import <Typhoon/Typhoon.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface DBHomeViewController ()

@property (nonatomic, strong) IBOutlet UIView *profileBackgroundView;
@property (nonatomic, strong) IBOutlet UIView *profileImageViewHolder;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) DBHomeViewModel *viewModel;

@end

@implementation DBHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self styleProfileView];
	[self styleNavigationBar];
	
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	
	id<DBGroupService> groupService = [factory groupService];
	id<DBProfileService> profileService = [factory profileService];
	
	self.viewModel = [[DBHomeViewModel alloc] initWithGroupService: groupService authService: profileService];
	
	[self applyBindings];
}

#pragma mark - Style profile views.

- (void) styleProfileView
{
	self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width * 0.5;
	self.profileImageView.clipsToBounds = YES;
	[self.profileImageView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
	
	self.profileImageViewHolder.layer.cornerRadius = self.profileImageViewHolder.frame.size.width * 0.5;
	self.profileImageViewHolder.clipsToBounds = YES;
	[self.profileBackgroundView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"profileBackground"]]];
}

#pragma mark - Style navigation bar.

- (void) styleNavigationBar
{
	self.navigationItem.titleView =
	[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"headerLogo"]];
}

#pragma mark - Bindings.

- (void) applyBindings
{
	@weakify(self);
	[[RACObserve(self.viewModel.profileViewModel, profileImage) distinctUntilChanged] subscribeNext:^(UIImage *image) {
		
		if (image != nil)
		{
			@strongify(self);
			[self.profileImageView setImage: image];
		}
		
	}];
}

#pragma mark - Actions.

- (IBAction) loginTapped: (UIButton *) sender
{
	[self performSegueWithIdentifier: @"settingsViewController" sender: self];
}

#pragma mark - Segue.

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString: @"settingsViewController"])
	{
		DBSettingsViewController *viewController = [segue destinationViewController];
		viewController.viewModel = self.viewModel.profileViewModel;
	}
}

#pragma mark - Tap actions.

- (IBAction) burgerButtonTapped: (UIBarButtonItem *)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DBBurgerButtonPressedNotification object: nil];
}

- (IBAction) addNewGroupTapped: (UIButton *) sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DBNewGroupPressedNotification object: nil];
}

@end
