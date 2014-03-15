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
#import "DBItemTableViewCell.h"
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
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UITableView *itemTableView;
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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemTableDistanceFromTopContraint;

@end

@implementation DBEditGroupViewController

static NSString *const DBItemTableViewId = @"DBItemCell";

static const float itemTableViewY = 147.0f;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setupScrollView];
	[self addGestures];
	[self styleItemTableView];
	[self styleImageView];
	[self applyBindings];
}

#pragma mark - Setup scroll view.

- (void) setupScrollView
{
	[self reloadScrollViewSize];
	[self.scrollView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
}

- (void) reloadScrollViewSize
{
//	self.contentHolder.frame = ({
//		CGRect frame = self.contentHolder.frame;
//		CGRect itemTableFrame = [self.itemTableView.superview convertRect: self.itemTableView.frame toView: self.contentHolder];
//		itemTableFrame.size.height = self.itemTableView.contentSize.height;
//		frame.size.height = CGRectGetMaxY(itemTableFrame);
//		frame;
//	});
//	
//	self.scrollView.contentSize = self.contentHolder.frame.size;
}

# pragma mark - Create image filter.

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

#pragma mark - Image header style.

- (void) styleImageView
{
	self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width * 0.5;
	self.profileImageView.clipsToBounds = YES;
	self.profileImageView.layer.borderColor = [[UIColor colorWithRed: 124.0f/255.0f green: 124.0f/255.0f blue: 124.0f/255.0f alpha: 0.4f] CGColor];
	self.profileImageView.layer.borderWidth = 2.0f;
	[self.profileImageView setHidden: YES];
}


# pragma mark - Item table view style.

- (void) styleItemTableView
{
	[self.itemTableView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"addAreaBackground"]]];
	[self reloadItemTableViewSize];
}

#pragma mark - Item tableview size.

- (CGSize) sizeForItemTableView
{
	static NSInteger buffer = 600;
	
	CGSize size = self.itemTableView.contentSize;

	CGRect frame = [self.itemTableView.superview convertRect: self.itemTableView.frame toView: self.contentHolder];
	frame.size.height = size.height;
	
	if (CGRectGetMaxY(frame) > CGRectGetMaxY(self.scrollView.bounds))
	{
		size.height += buffer;
		return size;
	}
	
	size.height = size.height + (CGRectGetMaxY(self.scrollView.bounds) - CGRectGetMaxY(frame));
	size.height += buffer;
	return size;
}

- (void) reloadItemTableViewSize
{
	float i = 0;
//	self.itemTableView.frame = ({
//		CGRect frame = self.itemTableView.frame;
//		frame.size.height = [self sizeForItemTableView].height;
//		frame;
//	});
}

#pragma mark - Bindings.

- (void) applyBindings
{
	[self bindUserInferface];
	[self bindViewModelProperties];
}

- (void) bindUserInferface
{
	RAC(self.groupNameTextField, text) = [RACObserve(self.viewModel, groupName) distinctUntilChanged];
	RAC(self.descriptionTextField, text) = [RACObserve(self.viewModel, groupDescription) distinctUntilChanged];
	RAC(self.navigationBar.topItem, title) = RACObserve(self.viewModel, groupName);
	
	RAC(self.addImageButton, hidden) = [RACObserve(self.profileImageView, image) map:^NSNumber *(UIImage *image) {
		BOOL isNull = image == nil;
		return @(!isNull);
	}];
	
	RAC(self.editImageButton, hidden) = [RACObserve(self.profileImageView, image) map:^NSNumber *(UIImage *image) {
		BOOL isNull = image == nil;
		return @(isNull);
	}];
	
	@weakify(self);
	[self.viewModel.saveCommand.executionSignals subscribeNext:^(RACSignal *signal) {
		
		[signal subscribeError:^(NSError *error) {

			// TODO: Handle error.
			
		} completed:^{
			
			@strongify(self);
			if([self.delegate respondsToSelector: @selector(editGroupViewControllerDidSave:)])
			{
				[self.delegate editGroupViewControllerDidSave: self];
			}
			[self dismissViewControllerAnimated: YES completion: NULL];
			
		}];
	}];
	
	self.saveButton.rac_command = self.viewModel.saveCommand;
}

- (void) bindViewModelProperties
{
	RAC(self.viewModel, groupName) = self.groupNameTextField.rac_textSignal;
	RAC(self.viewModel, groupDescription) = self.descriptionTextField.rac_textSignal;
	
	@weakify(self);
	[RACObserve(self.viewModel, image) subscribeNext:^(UIImage *image) {
		
		@strongify(self);
		
		if (image != nil)
		{
			[self.spinner startAnimating];
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				
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

- (IBAction) addNewItemTapped: (UIButton *) sender
{
	[self.scrollView setContentOffset:CGPointZero animated: YES];
	[self removePhotoGestures];
	[self addCloseEditItemGesture];
	
	DBItemViewModel *viewModel = [self.viewModel addItem];

	@weakify(self);
	[self showEditItemViewWithCompletion:^(BOOL finished) {
		
		@strongify(self);
		[self.itemTableView beginUpdates];
		NSIndexPath *path = [NSIndexPath indexPathForItem: [self.viewModel.items indexOfObject: viewModel] inSection:0];
		self.selectedIndexPath = path;
		[self.itemTableView insertRowsAtIndexPaths: @[path] withRowAnimation: UITableViewRowAnimationRight];
		[self.itemTableView endUpdates];

		[self performSelector: @selector(reloadItemTableViewSize) withObject: nil afterDelay: 0.4f];
		[self performSelector: @selector(reloadScrollViewSize) withObject: nil afterDelay: 0.4f];
		
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

- (void) addCloseEditItemGesture
{
	UILongPressGestureRecognizer *imageDownGesutre = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(closeEditItemTapped:)];
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

- (void) closeEditItemTapped: (UILongPressGestureRecognizer *) gesture
{
	if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
	{
		[self resignFirstResponder];
		[self removePhotoGestures];
		[self addEditPhotoGesture];
	}
}

#pragma mark - First responder.

- (BOOL) resignFirstResponder
{
	[self.selectedResponder resignFirstResponder];
	DBItemTableViewCell *cell = (DBItemTableViewCell *)[self.itemTableView cellForRowAtIndexPath: self.selectedIndexPath];
	cell.isInFocus = NO;
	@weakify(self);
	[self hideEditItemViewWithCompletion:^(BOOL finished) {
		
		@strongify(self);
		
		[self reloadItemTableViewSize];
		[self reloadScrollViewSize];
		self.selectedIndexPath = nil;
		
	}];
	return [super resignFirstResponder];
}

#pragma mark - Nav bar actions.

- (IBAction) cancelButtonTapped: (UIButton *) sender
{
	if([self.delegate respondsToSelector: @selector(editGroupViewControllerDidCancel:)])
	{
		[self.delegate editGroupViewControllerDidCancel: self];
	}
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

#pragma mark - Show/hide edit item.

- (void) showEditItemViewWithCompletion: (void (^)(BOOL finished))completion
{
	@weakify(self);
	[self.itemTableView.superview layoutIfNeeded];
	[UIView animateWithDuration: 0.6f
						  delay: 0.0f
		 usingSpringWithDamping: 0.8f
		  initialSpringVelocity: 0.2f
						options: UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 
						 @strongify(self);
						 self.itemTableDistanceFromTopContraint.constant = 0.0f;
						 [self.itemTableView.superview layoutIfNeeded];

					 } completion: completion];
}

- (void) hideEditItemViewWithCompletion: (void (^)(BOOL finished))completion
{
	@weakify(self);
	[self.itemTableView.superview layoutIfNeeded];
	[UIView animateWithDuration: 0.6f
						  delay: 0.0f
		 usingSpringWithDamping: 0.8f
		  initialSpringVelocity: 0.2f
						options: UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 
						 @strongify(self);
						 self.itemTableDistanceFromTopContraint.constant = 148.0f;
						 [self.itemTableView.superview layoutIfNeeded];
						 
					 } completion: completion];
}

#pragma mark - Item table view scroll to cell.

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
	UITableViewCell *cell = [self.itemTableView cellForRowAtIndexPath: indexPath];
	
	CGPoint origin = cell.frame.origin;
	CGPoint point = [cell.superview convertPoint: origin toView: self.itemTableView];
	CGPoint offset = CGPointZero;
	offset.y = (point.y - 44.0f);
	
	[self.itemTableView setContentOffset: offset animated: animated];
}

#pragma mark - Tableview data source.

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.viewModel.items.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DBItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DBItemTableViewId];
	cell.viewModel = [self.viewModel.items objectAtIndex: indexPath.row];
	cell.delegate = self;
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
	DBItemTableViewCell *cell = (DBItemTableViewCell *)[self.itemTableView cellForRowAtIndexPath: self.selectedIndexPath];
	cell.isInFocus = YES;
	
	[self.scrollView setContentOffset:CGPointZero animated: YES];
	[self scrollToCell: indexPath];
	[self removePhotoGestures];
	[self addCloseEditItemGesture];
	
	@weakify(self);
	[self showEditItemViewWithCompletion:^(BOOL finished) {
	
		@strongify(self);
		[self performSelector: @selector(reloadItemTableViewSize) withObject: nil afterDelay: 0.4f];
		[self performSelector: @selector(reloadScrollViewSize) withObject: nil afterDelay: 0.4f];
		[self performSelector: @selector(snapToCell:) withObject: indexPath afterDelay: 0.4f];

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

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(self.selectedIndexPath)
	{
		return NO;
	}
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		DBItemViewModel	*viewModel = [self.viewModel.items objectAtIndex: indexPath.row];
		[self.viewModel deleteItem: viewModel];
		[self.itemTableView beginUpdates];
		[self.itemTableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationLeft];
		[self.itemTableView endUpdates];
	}
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"Remove";
}

#pragma mark - Item table view cell delegate.

- (void) itemTableViewCellDidEndEditing:(DBItemTableViewCell *)cell
{
	[self resignFirstResponder];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
