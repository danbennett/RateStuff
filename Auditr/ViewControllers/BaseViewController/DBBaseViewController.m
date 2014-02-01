//
//  DBBaseViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBBaseViewModel.h"
#import "UIView+Animations.h"

NSString *const DBBurgerButtonPressedNotification = @"burgerButtonPressedNotification";

@interface DBBaseViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *groupTableView;
@property (nonatomic, weak) DBBaseViewModel *viewModel;

@end

@implementation DBBaseViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	
	DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
	self.viewModel = (DBBaseViewModel *)[factory baseViewModel];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(burgerButtonPressedNotifcationHandler:)
												 name: DBBurgerButtonPressedNotification
											   object: nil];
	
	[self applyBindings];
	[self addSwipeGesutre];
}

- (void) applyBindings
{
	[self.viewModel.groups subscribeNext:^(NSArray *groups) {
		
	}];
}

- (void) addSwipeGesutre
{
	UISwipeGestureRecognizer *swipeGestureRecoginzer =
	[[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(startDragging:)];
	swipeGestureRecoginzer.direction = (UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight);
	[self.containerView addGestureRecognizer: swipeGestureRecoginzer];
}

- (void) addTapGesture
{
	UITapGestureRecognizer *tapGestureRecoginzer =
	[[UITapGestureRecognizer alloc] initWithTarget: self  action: @selector(openBurgerMenuTapped:)];
	tapGestureRecoginzer.cancelsTouchesInView = NO;
	[self.containerView addGestureRecognizer: tapGestureRecoginzer];
}

- (void) openBurgerMenuTapped: (UITapGestureRecognizer *) gesture
{
	[self.containerView removeGestureRecognizer: gesture];
	
	[self.containerView animateToPosition: CGPointZero withDuration: 0.4f withEase: CircularEaseOut];
}

- (void) startDragging: (UISwipeGestureRecognizer *) gesture
{
	UIPanGestureRecognizer *panGesture;
	if(gesture.state == UIGestureRecognizerStateBegan ||
	   gesture.state == UIGestureRecognizerStateRecognized)
	{
		panGesture =
		[[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(isDragging:)];
		[self.containerView addGestureRecognizer: panGesture];
	}
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
		currentFrame.origin.x = newX;
		gesture.view.frame = currentFrame;
		
		[gesture setTranslation: CGPointMake(0, 0) inView: self.view];
	}
	
	if(gesture.state == UIGestureRecognizerStateCancelled ||
	   gesture.state == UIGestureRecognizerStateEnded ||
	   gesture.state == UIGestureRecognizerStateFailed)
	   {
		   [self droppedWithVelocity: [gesture velocityInView: self.view].x];
		   [self.containerView removeGestureRecognizer: gesture];
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
	ViewEasingFunctionPointerType ease = CircularEaseOut;
	
	if(fabs(speed) > 300)
	{
		positionToAnimateTo = [self positionWithVelocity: speed];
	}
	
	CGFloat xPoints = CGRectGetWidth(self.groupTableView.frame);
	NSTimeInterval duration = fabs( xPoints / speed );
	duration = duration > 0.4f ? 0.4f : duration;
	
	[self.containerView animateToPosition: positionToAnimateTo withDuration: duration withEase: ease];
	
	if (positionToAnimateTo.x < 0)
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

- (void) burgerButtonPressedNotifcationHandler: (NSNotification *) notification
{
	CGPoint position = CGPointMake(-CGRectGetWidth(self.groupTableView.frame), 0.0);
	[self.containerView animateToPosition: position withDuration: 0.4f withEase: CircularEaseOut];
	
	[self addTapGesture];
}

- (void) dealloc
{
	[self removeObservers];
}

- (void) removeObservers
{
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: DBBurgerButtonPressedNotification
												  object: nil];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
