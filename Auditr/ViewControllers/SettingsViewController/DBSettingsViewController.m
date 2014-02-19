//
//  DBSettingsViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsViewController.h"
#import "DBSettingsViewModel.h"
#import "DBProfileService.h"
#import "DBProfileViewModel.h"
#import "DBSettingsTableViewCell.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBSettingsViewController ()

@property (nonatomic, strong) NSArray *accounts;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

NSString *const DBTwitterAccountError = @"Could not find any Twitter accounts. Please add an account in the settings.";
NSString *const DBTwitterConnectionError = @"There was a problem connecting to the server. Please try again later.";

static NSString *const DBSettingsTwitterCellId = @"DBSettingsTwitterCell";
static NSString *const SettingsTwitterDefaultLabel = @"Choose a twitter account...";

@implementation DBSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self applyBindings];
}

#pragma mark - Bindings.

- (void) applyBindings
{
	RAC(self, title) = RACObserve(self.viewModel, profileName);
	
	[self bindChooseTwitterAccountCommand];
	
	[self bindLoginWithAccountCommand];
}

- (void) bindChooseTwitterAccountCommand
{
	@weakify(self);

	[self.viewModel.chooseTwitterAccountCommand.executionSignals subscribeNext:^(RACSignal *signal) {
		
		[signal subscribeNext:^(NSArray *accounts) {
			@strongify(self);
			[self loadTwitterAccountFromAccounts: accounts];
			
		} error:^(NSError *error) {
			@strongify(self);
			[self showAlertWithMessage: DBTwitterAccountError withTitle: @"Error"];
			
		}];
		
	}];
}

- (void) bindLoginWithAccountCommand
{
	@weakify(self);
	
	[self.viewModel.loginWithAccountCommand.executionSignals subscribeNext:^(RACSignal *signal) {
		
		[signal subscribeNext:^(id x) {
			
			@strongify(self);
			[self.viewModel activateProfile];
			
		} error:^(NSError *error) {
			@strongify(self);
			[self showAlertWithMessage: DBTwitterConnectionError withTitle: @"Error"];
			[self.viewModel deleteProfile];
		}];
		
	}];
}

- (void) loadTwitterAccountFromAccounts: (NSArray *) accounts
{
	if (accounts.count > 0)
	{
		self.accounts = accounts;
		[self showActionSheetWithAccountNames: [accounts valueForKeyPath: @"username"]];
	}
	else
	{
		[self.viewModel.loginWithAccountCommand execute: [accounts firstObject]];
	}
}

#pragma mark - Actions.

- (IBAction) cancelButtonTapped: (UIBarButtonItem *) sender
{
	[self dismissViewControllerAnimated: YES completion: NULL];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Bar positioning delegate.

- (UIBarPosition) positionForBar:(id<UIBarPositioning>) bar
{
	return UIBarPositionTopAttached;
}

#pragma mark - Table view data source.

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DBSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DBSettingsTwitterCellId];
	cell.viewModel = self.viewModel;
	return cell;
}

#pragma mark - Table view delegate.

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
	{
		[self.viewModel.chooseTwitterAccountCommand execute: [NSNull null]];
	}
	return indexPath;
}

#pragma mark - Action sheet.

- (void) showActionSheetWithAccountNames: (NSArray *) accountNames
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Choose account"
															 delegate: self
													cancelButtonTitle: nil
											   destructiveButtonTitle: nil
													otherButtonTitles: nil, nil];
	
	[accountNames enumerateObjectsUsingBlock:^(NSString *accountName, NSUInteger idx, BOOL *stop) {
		[actionSheet addButtonWithTitle: accountName];
	}];
	
	[actionSheet addButtonWithTitle: @"Cancel"];
	actionSheet.destructiveButtonIndex = [accountNames count];
	
	[actionSheet showInView: self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	ACAccount *account = [self.accounts objectAtIndex: buttonIndex];
	[self.viewModel.loginWithAccountCommand execute: account];
}

#pragma mark - Alert.

- (void) showAlertWithMessage: (NSString *) message withTitle: (NSString *) title
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
													message: message
												   delegate: nil
										  cancelButtonTitle: @"OK"
										  otherButtonTitles: nil, nil];
	[alert show];
}

@end
