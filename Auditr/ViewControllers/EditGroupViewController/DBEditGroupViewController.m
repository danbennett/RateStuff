//
//  DBEditGroupViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBEditGroupViewController.h"
#import "DBGroupViewModel.h"
#import "DBImagePickerViewController.h"
#import "UIImage+Effects.h"
#import <QuartzCore/QuartzCore.h>

@interface DBEditGroupViewController ()

@property (nonatomic, strong) UIResponder *selectedResponder;
@property (nonatomic, strong) IBOutlet UIButton *editImageButton;
@property (nonatomic, strong) IBOutlet UIButton *addImageButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITableView *groupTableView;
@property (nonatomic, strong) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *imageViewHolder;
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
	
	[self addGesture];
	[self styleGroupTableView];
	[self styleImageBackground];
	[self applyBindings];
}

# pragma mark - Style.

- (void) styleGroupTableView
{
	self.groupTableView.layer.borderColor = [[UIColor colorWithRed: 124.0f/255.0f green: 124.0f/255.0f blue: 124.0f/255.0f alpha: 0.4f] CGColor];
	self.groupTableView.layer.cornerRadius = 5;
	self.groupTableView.layer.borderWidth = 0.5f;
}

- (void) styleImageBackground
{
//	UIImage *backgroundImage = [[UIImage imageNamed:@"imageBackground"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
	[self.imageViewHolder setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
//	[self.imageViewHolder setImage: backgroundImage];
}

#pragma mark - Bindings.

- (void) applyBindings
{
	RAC(self.saveButton, enabled) = self.viewModel.valid;
	RAC(self.viewModel, groupName) = self.groupNameTextField.rac_textSignal;
	RAC(self.viewModel, description) = self.descriptionTextField.rac_textSignal;
	
	RAC(self.groupNameTextField, text) = [RACObserve(self.viewModel, groupName) distinctUntilChanged];
	RAC(self.descriptionTextField, text) = [RACObserve(self.viewModel, description) distinctUntilChanged];
	
	@weakify(self);
	[RACObserve(self.viewModel, image) subscribeNext:^(UIImage *image) {
		
		dispatch_queue_t blurQueue = dispatch_queue_create("uk.co.bennett.dan.blurQueu", NULL);
		__block UIImage *blurredImage = nil;
		__block UIImage *vignetteImage = nil;
		dispatch_async(blurQueue, ^{
			
			blurredImage = [image imageWithBlur];
			vignetteImage = [image imageWithVignette];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				@strongify(self);
				[self.imageView setImage: blurredImage];
//				[self.profileImageView setImage: vignetteImage];
			});
		});
		
	}];
	
	RAC(self.addImageButton, hidden) = [RACObserve(self.profileImageView, image) map:^NSNumber *(UIImage *image) {
		BOOL isNull = image == nil;
		return @(!isNull);
	}];
	
	RAC(self.editImageButton, hidden) = [RACObserve(self.profileImageView, image) map:^NSNumber *(UIImage *image) {
		BOOL isNull = image == nil;
		return @(isNull);
	}];
}

#pragma mark - Bar positioning delegate.

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self resignFirstResponder];
	return YES;
}

#pragma mark - Actions.

- (void) addGesture
{
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(resignFirstResponder)];
	gesture.cancelsTouchesInView = NO;
	[self.scrollView addGestureRecognizer: gesture];
}

- (BOOL) resignFirstResponder
{
	[self.selectedResponder resignFirstResponder];
	return [super resignFirstResponder];
}

- (IBAction) cancelButtonTapped: (UIButton *) sender
{
	[self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction) addPhotoTapped: (UIButton *) sender
{
	UIActionSheet *actionSheet =
	[[UIActionSheet alloc] initWithTitle: nil
								delegate: self
					   cancelButtonTitle: @"Cancel"
				  destructiveButtonTitle: nil
					   otherButtonTitles: @"Take new photo...", @"Choose existing photo...", nil];
	[actionSheet showInView: self.view];
}

# pragma mark - Action sheet delegate.

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[self showImagePickerWithSourceType: UIImagePickerControllerSourceTypeCamera];
	}
	else if(buttonIndex == 1)
	{
		[self showImagePickerWithSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
	}
}

- (void) showImagePickerWithSourceType: (UIImagePickerControllerSourceType) sourceType
{
	DBImagePickerViewController *imagePicker = [[DBImagePickerViewController alloc] init];
	imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
	imagePicker.sourceType = sourceType;
	imagePicker.delegate = self;
	[self presentViewController: imagePicker animated: YES completion: nil];
}

#pragma mark - Image picker delegate.

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissViewControllerAnimated: YES completion: nil];
	
	UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
	self.viewModel.image = image;
}

#pragma mark - Navigation controller delegate.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
