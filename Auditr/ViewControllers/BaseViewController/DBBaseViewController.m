//
//  DBBaseViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBBaseViewModel.h"
#import "DBGroupTableViewCell.h"
#import "UIView+Animations.h"
#import "DBEditGroupViewController.h"
#import <ReactiveCocoa/RACEXTScope.h>

NSString *const DBBurgerButtonPressedNotification = @"burgerButtonPressedNotification";
NSString *const DBNewGroupPressedNotification = @"newGroupPressedNotifcation";

@interface DBBaseViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *closeBurgerGesture;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIView *statusBarBackground;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITableView *groupTableView;
@property (nonatomic, strong) DBBaseViewModel *viewModel;

@end

static NSString *const DBGroupTableViewCellId = @"DBGroupCell";

@implementation DBBaseViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	[self setNeedsStatusBarAppearanceUpdate];
	
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	id<DBGroupService> groupService = [factory groupService];
	self.viewModel = [[DBBaseViewModel alloc] initWithGroupService: groupService];
	
	[self addObservers];
	
	[self applyBindings];
	[self addSwipeGesutre];
}

- (void) addObservers
{
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(burgerButtonPressedNotifcationHandler:)
												 name: DBBurgerButtonPressedNotification
											   object: nil];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(newGroupPressedNotificationHandler:)
												 name: DBNewGroupPressedNotification
											   object: nil];

}

- (void) applyBindings
{
	@weakify(self);
	[RACObserve(self.viewModel, groups) subscribeNext:^(NSArray *groups) {
		@strongify(self);
		[self.groupTableView reloadData];
	}];
}

# pragma mark - burger menu.

- (void) addSwipeGesutre
{
	UIPanGestureRecognizer *panGesture =
	[[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(isDragging:)];
	panGesture.delegate = self;
	[self.containerView addGestureRecognizer: panGesture];
}

- (BOOL) gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
	CGPoint translation = [gestureRecognizer translationInView: self.view];
    return fabs(translation.x) > fabs(translation.y);
}

- (void) addTapGesture
{
	self.closeBurgerGesture =
	[[UITapGestureRecognizer alloc] initWithTarget: self  action: @selector(openBurgerMenuTapped:)];
	self.closeBurgerGesture.cancelsTouchesInView = NO;
	[self.containerView addGestureRecognizer: self.closeBurgerGesture];
}

- (void) openBurgerMenuTapped: (UITapGestureRecognizer *) gesture
{
	[self.containerView removeGestureRecognizer: self.closeBurgerGesture];
	
	[self.containerView animateToPosition: CGPointZero withDuration: 0.2f withEase: UIViewAnimationOptionCurveEaseOut withCompletion: NULL];
	[self.statusBarBackground animateToOpacity: 0.0f withDuration: 0.2f];
}

- (void) burgerButtonPressedNotifcationHandler: (NSNotification *) notification
{
	CGPoint position = CGPointMake(-CGRectGetWidth(self.groupTableView.frame), 0.0);
	[self.containerView animateToPosition: position withDuration: 0.2f withEase: UIViewAnimationOptionCurveEaseOut withCompletion: NULL];
	[self.statusBarBackground animateToOpacity: 1.0f withDuration: 0.2f];
	
	[self addTapGesture];
}

- (void) isDragging: (UIPanGestureRecognizer *) gesture
{
	if(gesture.state == UIGestureRecognizerStateChanged)
	{
		CGPoint translation = [gesture translationInView: self.view];
		
		CGRect currentFrame = gesture.view.frame;
		double newX = gesture.view.frame.origin.x + translation.x;
		if(newX < -self.groupTableView.frame.size.width)
		{
			newX = -self.groupTableView.frame.size.width;
		}
		else if(newX > 0)
		{
			newX = 0;
		}
		currentFrame.origin.x = newX;
		gesture.view.frame = currentFrame;
		
		[gesture setTranslation: CGPointMake(0, 0) inView: self.view];
		[self updateStatusBarColour];
	}
	
	if(gesture.state == UIGestureRecognizerStateCancelled ||
	   gesture.state == UIGestureRecognizerStateEnded ||
	   gesture.state == UIGestureRecognizerStateFailed)
	   {
		   [self droppedWithVelocity: [gesture velocityInView: self.view].x];
	   }
}

- (void) droppedWithVelocity: (CGFloat) velocity
{
	CGPoint currentPosition = self.containerView.frame.origin;
	[self putViewAtPositionWith: currentPosition swipeSpeed: velocity];
}

- (void) putViewAtPositionWith: (CGPoint) position swipeSpeed: (CGFloat) speed
{
	CGPoint positionToAnimateTo = [self positionWithPosition: position];
	
	if(fabs(speed) > 300)
	{
		positionToAnimateTo = [self positionWithVelocity: speed];
	}
	
	CGFloat xPoints = CGRectGetWidth(self.groupTableView.frame);
	NSTimeInterval duration = fabs( xPoints / speed );
	duration = duration > 0.32f ? 0.32f : duration;
	
	[self.containerView animateToPosition: positionToAnimateTo withDuration: duration withEase: UIViewAnimationOptionCurveEaseOut withCompletion: NULL];
	
	BOOL isOpen = positionToAnimateTo.x < 0;
	float opacity = (isOpen) ? 1.0f : 0.0f;
	[self.statusBarBackground animateToOpacity: opacity withDuration: duration];
	
	if (isOpen)
	{
		[self addTapGesture];
	}
}

- (CGPoint) positionWithVelocity: (CGFloat) velocity
{
	CGPoint positionToAnimateTo = CGPointZero;
	if(velocity < 0)
	{
		positionToAnimateTo = CGPointMake(-CGRectGetWidth(self.groupTableView.frame), 0.0);
	}
	return positionToAnimateTo;
}

- (CGPoint) positionWithPosition: (CGPoint) position
{
	CGPoint positionToAnimateTo = CGPointZero;
	CGSize slideWindowWidth = self.groupTableView.frame.size;
	
	if(position.x < -(slideWindowWidth.width * 0.5))
	{
		positionToAnimateTo = CGPointMake(-CGRectGetWidth(self.groupTableView.frame), 0.0);
	}
	return positionToAnimateTo;
}

#pragma mark - Status bar.

- (void) updateStatusBarColour
{
	float currentX = self.containerView.frame.origin.x;
	float targetX = -self.groupTableView.frame.size.width;
	float percentage = fabs(currentX / targetX);
	
	[self.statusBarBackground setAlpha: percentage];
}

#pragma mark - search bar.

- (void) searchBar: (UISearchBar *)searchBar textDidChange: (NSString *) text
{
	
}

# pragma mark - group management.

- (IBAction) addNewGroup: (UIButton *) sender
{
	[self.containerView removeGestureRecognizer: self.closeBurgerGesture];
	
	@weakify(self);
	[self.containerView animateToPosition: CGPointZero withDuration: 0.2f withEase: UIViewAnimationOptionCurveEaseOut withCompletion:^(BOOL finished) {
		@strongify(self);
		[self performSegueWithIdentifier: @"editGroupViewController" sender: self];
	}];
	[self.statusBarBackground animateToOpacity: 0.0f withDuration: 0.2f];
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id) sender
{
	if ([segue.identifier isEqualToString: @"editGroupViewController"])
	{
		DBEditGroupViewController *viewController = segue.destinationViewController;
		viewController.delegate = self;
		viewController.viewModel = [self.viewModel newGroupViewModel];
	}
}

- (void) newGroupPressedNotificationHandler: (NSNotification *) notification
{
	[self addNewGroup: nil];
}

#pragma mark - Edit group delegate.

- (void) editGroupViewControllerDidSave:(DBEditGroupViewController *)viewController
{
	
}

- (void) editGroupViewControllerDidCancel:(DBEditGroupViewController *)viewController
{
	[self.viewModel deleteGroupViewModel: viewController.viewModel];
}

#pragma mark - Table view data source.

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.viewModel.groups.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DBGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DBGroupTableViewCellId];
	cell.viewModel = [self.viewModel.groups objectAtIndex: indexPath.row];
	return cell;
}

#pragma mark - Table view delegate.

- (void) dealloc
{
	[self removeObservers];
}

- (void) removeObservers
{
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: DBBurgerButtonPressedNotification
												  object: nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: DBNewGroupPressedNotification
												  object: nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
