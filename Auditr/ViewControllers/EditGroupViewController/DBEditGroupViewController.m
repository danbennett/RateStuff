//
//  DBEditGroupViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBEditGroupViewController.h"
#import "DBGroupViewModel.h"

@interface DBEditGroupViewController ()

@property (nonatomic, strong) UIResponder *selectedResponder;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UITextField *groupNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *descriptionTextField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;

@end

@implementation DBEditGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self styleImageBackground];
	[self applyBindings];
}

- (void) styleImageBackground
{
	UIImage *backgroundImage = [[UIImage imageNamed:@"imageBackground"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
	[self.imageView setImage: backgroundImage];
}

#pragma mark - Bindings.

- (void) applyBindings
{
	RAC(self.saveButton, enabled) = self.viewModel.valid;
	RAC(self.viewModel, groupName) = self.groupNameTextField.rac_textSignal;
	RAC(self.viewModel, description) = self.descriptionTextField.rac_textSignal;
}

#pragma mark - Bar positioning.

- (UIBarPosition) positionForBar:(id<UIBarPositioning>) bar
{
	return UIBarPositionTopAttached;
}

#pragma mark - Textfield delegate.

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	self.selectedResponder = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	self.selectedResponder = nil;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.selectedResponder resignFirstResponder];
}

#pragma mark - Actions.

- (IBAction) cancelButtonTapped: (UIButton *) sender
{
	[self dismissViewControllerAnimated: YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
