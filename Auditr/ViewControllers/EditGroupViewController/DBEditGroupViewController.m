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
#import "DBAreaTableViewCell.h"
#import "UIImage+Effects.h"
#import "UIView+Animations.h"
#import <GPUImage/GPUImage.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <QuartzCore/QuartzCore.h>

@interface DBEditGroupViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UIImage *backgroundImageUp;
@property (nonatomic, strong) UIImage *backgroundImageOver;
@property (nonatomic, strong) UIResponder *selectedResponder;
@property (nonatomic, strong) IBOutlet UITableView *areaTableView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) IBOutlet UIButton *editImageButton;
@property (nonatomic, strong) IBOutlet UIButton *addImageButton;
@property (nonatomic, strong) IBOutlet UIView *contentHolder;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
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

static NSString *const DBDefaultAreaName = @"New ratable area";
static NSString *const DBAreaTableViewId = @"DBAreaCell";
static const float areaTableViewY = 147.0f;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setupScrollView];
	[self addGestures];
	[self styleAreaTableView];
	[self styleImageView];
	[self applyBindings];
}

#pragma mark - Scroll view.

- (void) setupScrollView
{
	[self reloadScrollViewSize];
	[self.scrollView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
}

- (void) reloadScrollViewSize
{
	self.contentHolder.frame = ({
		CGRect frame = self.contentHolder.frame;
		CGRect areaTableFrame = [self.areaTableView.superview convertRect: self.areaTableView.frame toView: self.contentHolder];
		frame.size.height = CGRectGetMaxY(areaTableFrame);
		frame;
	});
	
	self.scrollView.contentSize = self.contentHolder.frame.size;
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

- (void) styleAreaTableView
{
	[self.areaTableView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"addAreaBackground"]]];
	self.areaTableView.frame = ({
		CGRect frame = self.areaTableView.frame;
		frame.size.height = [self sizeForAreaTableView].height;
		frame;
	});
}

#pragma mark - Area tableview size.

- (CGSize) sizeForAreaTableView
{
	CGSize size = self.areaTableView.contentSize;

	CGRect frame = [self.areaTableView.superview convertRect: self.areaTableView.frame toView: self.contentHolder];
	frame.size.height = size.height;
	
	if (CGRectGetMaxY(frame) > CGRectGetMaxY(self.scrollView.bounds))
	{
		return size;
	}
	
	size.height = size.height + (CGRectGetMaxY(self.scrollView.bounds) - CGRectGetMaxY(frame));
	return size;
}

- (void) reloadAreaTableViewSize
{
	self.areaTableView.frame = ({
		CGRect frame = self.areaTableView.frame;
		frame.size.height = [self sizeForAreaTableView].height;
		frame;
	});
	
//	if (self.selectedIndexPath != nil)
//	{
//		UITableViewCell *cell = [self.areaTableView cellForRowAtIndexPath: self.selectedIndexPath];
//		[self scrollToCell: cell animated: NO];
//	}
}

- (void) styleImageView
{
	self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width * 0.5;
	self.profileImageView.clipsToBounds = YES;
	self.profileImageView.layer.borderColor = [[UIColor colorWithRed: 124.0f/255.0f green: 124.0f/255.0f blue: 124.0f/255.0f alpha: 0.4f] CGColor];
	self.profileImageView.layer.borderWidth = 2.0f;
	[self.profileImageView setHidden: YES];
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
			[self.spinner startAnimating];
			dispatch_queue_t blurQueue = dispatch_queue_create("uk.co.bennett.dan.imageFilterQueue", NULL);
			dispatch_async(blurQueue, ^{

				@strongify(self);
				[self createBackgroundImagesWithImage: image];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					@strongify(self);
					[self.spinner stopAnimating];
					[self.profileImageView setImage: image];
					self.profileImageView.alpha = 0.0f;
					[self.profileImageView animateToOpacity: 1.0f withDuration: 0.32f];
					[self.profileImageView setHidden: NO];
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

- (IBAction) addNewAreaTapped: (UIButton *) sender
{
	[self.scrollView setContentOffset:CGPointZero animated: YES];
	[self removePhotoGestures];
	[self addCloseEditAreaGesture];
	
	DBAreaViewModel *viewModel = [self.viewModel addAreaWithName: DBDefaultAreaName];

	@weakify(self);
	[self showEditAreaViewWithCompletion:^(BOOL finished) {
		
		@strongify(self);
		[self.areaTableView beginUpdates];
		NSIndexPath *path = [NSIndexPath indexPathForItem: [self.viewModel.areas indexOfObject: viewModel] inSection:0];
		self.selectedIndexPath = path;
		[self.areaTableView insertRowsAtIndexPaths: @[path] withRowAnimation: UITableViewRowAnimationRight];
		[self.areaTableView endUpdates];
		
		[self performSelector: @selector(reloadAreaTableViewSize) withObject: nil afterDelay: 1.0f];
		[self performSelector: @selector(reloadScrollViewSize) withObject: nil afterDelay: 1.0f];
		
	}];
}

#pragma mark - Gestures.

- (void) addGestures
{
	[self addEditPhotoGesture];
	[self addResignFirstResponderGesture];
}

- (void) addResignFirstResponderGesture
{
	UITapGestureRecognizer *responderGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(resignFirstResponder)];
	responderGesture.cancelsTouchesInView = NO;
	[self.scrollView addGestureRecognizer: responderGesture];
}

- (void) addEditPhotoGesture
{
	UILongPressGestureRecognizer *imageDownGesutre = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(editPhotoTapped:)];
	imageDownGesutre.cancelsTouchesInView = NO;
	imageDownGesutre.minimumPressDuration = .0001;
	[self.imageViewHolder addGestureRecognizer: imageDownGesutre];
}

- (void) addCloseEditAreaGesture
{
	UILongPressGestureRecognizer *imageDownGesutre = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(closeEditAreaTapped:)];
	imageDownGesutre.cancelsTouchesInView = NO;
	imageDownGesutre.minimumPressDuration = .0001;
	[self.imageViewHolder addGestureRecognizer: imageDownGesutre];
}

- (void) removePhotoGestures
{
	for (UIGestureRecognizer *gestureRecoginzer in self.imageViewHolder.gestureRecognizers)
	{
		[self.imageViewHolder removeGestureRecognizer: gestureRecoginzer];
	}
}

- (void) editPhotoTapped: (UILongPressGestureRecognizer *) gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		[self resignFirstResponder];
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

- (void) closeEditAreaTapped: (UILongPressGestureRecognizer *) gesture
{
	if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
	{
		[self resignFirstResponder];
		[self removePhotoGestures];
		[self addEditPhotoGesture];
	}
}

- (BOOL) resignFirstResponder
{
	[self.selectedResponder resignFirstResponder];
	DBAreaTableViewCell *cell = (DBAreaTableViewCell *)[self.areaTableView cellForRowAtIndexPath: self.selectedIndexPath];
	cell.isInFocus = NO;
	@weakify(self);
	[self hideEditAreaWithCompletion:^(BOOL finished) {
		
		@strongify(self);
		
		[self reloadAreaTableViewSize];
		[self reloadScrollViewSize];
		self.selectedIndexPath = nil;
		
	}];
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

#pragma mark - Show/hide edit area.

- (void) showEditAreaViewWithCompletion: (void (^)(BOOL finished))completion
{
	CGRect frame = self.areaTableView.frame;
	frame.size.height = frame.size.height + frame.origin.y;
	frame.origin.y = 0;
	[self.areaTableView animateFrameWithBounce: frame
								  withDuration: 0.6f
									  withEase: UIViewAnimationOptionCurveEaseOut
								withCompletion: completion];
}

- (void) hideEditAreaWithCompletion: (void (^)(BOOL finished))completion
{
	CGRect frame = self.areaTableView.frame;
	frame.origin.y = areaTableViewY;
	[self.areaTableView animateFrameWithBounce: frame
								  withDuration: 0.6f
									  withEase: UIViewAnimationOptionCurveEaseOut
								withCompletion: completion];

}

#pragma mark - Area table view scroll to cell.

- (void) scrollToCell: (NSIndexPath *) indexPath
{
	[self scrollTableViewCellIndex: indexPath WithAnimation: YES];
}

- (void) snapToCell: (NSIndexPath *) indexPath
{
	[self scrollTableViewCellIndex: indexPath WithAnimation: NO];
}

- (void) scrollTableViewCellIndex: (NSIndexPath *) indexPath WithAnimation: (BOOL) animated
{
	UITableViewCell *cell = [self.areaTableView cellForRowAtIndexPath: indexPath];
	
	CGPoint origin = cell.frame.origin;
	CGPoint point = [cell.superview convertPoint: origin toView: self.areaTableView];
	CGPoint offset = CGPointZero;
	offset.y = (point.y - 44.0f);
	
	[self.areaTableView setContentOffset: offset animated: animated];
}

#pragma mark - Tableview data source.

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.viewModel.areas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DBAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DBAreaTableViewId];
	cell.viewModel = [self.viewModel.areas objectAtIndex: indexPath.row];
	if ([self.selectedIndexPath isEqual: indexPath])
	{
		cell.isInFocus = YES;
	}
	return cell;
}

#pragma mark - Tableview delegate.

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.selectedIndexPath = indexPath;
	DBAreaTableViewCell *cell = (DBAreaTableViewCell *)[self.areaTableView cellForRowAtIndexPath: self.selectedIndexPath];
	cell.isInFocus = YES;
	
	[self.scrollView setContentOffset:CGPointZero animated: YES];
	[self scrollToCell: indexPath];
	[self removePhotoGestures];
	[self addCloseEditAreaGesture];
	
	@weakify(self);
	[self showEditAreaViewWithCompletion:^(BOOL finished) {
	
		@strongify(self);
		[self performSelector: @selector(reloadAreaTableViewSize) withObject: nil afterDelay: 1.0f];
		[self performSelector: @selector(reloadScrollViewSize) withObject: nil afterDelay: 1.0f];
		[self performSelector: @selector(snapToCell:) withObject: indexPath afterDelay: 1.0f];

	}];
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(self.selectedIndexPath)
	{
		return NO;
	}
	return indexPath;
}

#pragma mark - getters & setters.

@end
