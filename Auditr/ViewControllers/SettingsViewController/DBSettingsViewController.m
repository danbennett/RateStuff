//
//  DBSettingsViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsViewController.h"
#import "DBSettingsViewModel.h"
#import "DBTwitterAuthService.h"
#import "DBSettingsTableViewCell.h"

@interface DBSettingsViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DBSettingsViewModel *viewModel;

@end

static NSString *const DBSettingsTwitterCellId = @"DBSettingsTwitterCell";
static NSString *const SettingsTwitterDefaultLabel = @"Choose a twitter account...";

@implementation DBSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	DBAssembly *assembly = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	id<DBTwitterAuthService> twitterAuthService = [assembly twitterAuthService];
	
	self.viewModel = [[DBSettingsViewModel alloc] initWithTwitterAuthService: twitterAuthService];
	
	[self applyBindings];
}

#pragma mark - Bindings.

- (void) applyBindings
{
	[self.viewModel.chooseTwitterAccountCommand.executionSignals subscribeNext:^(RACSignal *signal) {
		
		[signal subscribeNext:^(UIImage *profilePicture) {
			
		} error:^(NSError *error) {
			
		}];
		
	}];
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
	cell.valueLabel.text = self.viewModel.twitterUsername ? : SettingsTwitterDefaultLabel;
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

@end
