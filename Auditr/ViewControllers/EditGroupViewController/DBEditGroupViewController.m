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
#import "UIView+Animations.h"
#import <GPUImage/GPUImage.h>
#import <QuartzCore/QuartzCore.h>

@interface DBEditGroupViewController ()

@property (nonatomic, strong) UIImage *backgroundImageUp;
@property (nonatomic, strong) UIImage *backgroundImageOver;
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
	
	[self addGestures];
	[self styleGroupTableView];
	[self styleImageBackground];
	[self applyBindings];
}

# pragma mark - Image filter.

- (void) createBackgroundImagesWithImage: (UIImage *) image
{
	GPUImagePolkaDotFilter *imageFilter = [[GPUImagePolkaDotFilter alloc] init];
	imageFilter.fractionalWidthOfAPixel = 0.02f;
	imageFilter.dotScaling = 0.9f;
	
	GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage: image];
	[stillImageSource addTarget: imageFilter];
	[stillImageSource processImage];
	
	self.backgroundImageUp = [imageFilter imageFromCurrentlyProcessedOutputWithOrientation: image.imageOrientation];

	imageFilter.fractionalWidthOfAPixel = 0.01f;
	[stillImageSource processImage];
	self.backgroundImageOver = [imageFilter imageFromCurrentlyProcessedOutputWithOrientation: image.imageOrientation];
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
	[self.imageViewHolder setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
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
		
		if (image != nil)
		{
			dispatch_queue_t blurQueue = dispatch_queue_create("uk.co.bennett.dan.blurQueu", NULL);
			dispatch_async(blurQueue, ^{

				@strongify(self);
				[self createBackgroundImagesWithImage: image];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					[self.profileImageView setImage: image];
					self.profileImageView.alpha = 0.0f;
					[self.profileImageView animateToOpacity: 1.0f withDuration: 0.32f];
					[self.imageView setImage: self.backgroundImageUp];
					self.imageView.alpha = 0.0f;
					[self.imageView animateToOpacity: 0.4f withDuration: 0.42f];
				});
			});
		}
		
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

- (void) addGestures
{
	UITapGestureRecognizer *responderGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(resignFirstResponder)];
	responderGesture.cancelsTouchesInView = NO;
	[self.scrollView addGestureRecognizer: responderGesture];
	
	UILongPressGestureRecognizer *imageDownGesutre = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(photoDown:)];
	imageDownGesutre.cancelsTouchesInView = NO;
	imageDownGesutre.minimumPressDuration = .0001;
	[self.imageViewHolder addGestureRecognizer: imageDownGesutre];
}

- (void) photoDown: (UILongPressGestureRecognizer *) gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		[self.imageView setImage: self.backgroundImageOver];
	}
	if (gesture.state == UIGestureRecognizerStateChanged)
	{
		CGPoint location = [gesture locationInView: self.imageViewHolder];
		BOOL isInView = [self.imageViewHolder pointInside: location withEvent: nil];
		gesture.enabled = isInView;
	}
	if (gesture.state == UIGestureRecognizerStateEnded)
	{
		[self.imageView setImage: self.backgroundImageUp];
		[self addPhoto];
	}
	if (gesture.state == UIGestureRecognizerStateCancelled)
	{
		[self.imageView setImage: self.backgroundImageUp];
		gesture.enabled = TRUE;
	}
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

- (void) addPhoto
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
