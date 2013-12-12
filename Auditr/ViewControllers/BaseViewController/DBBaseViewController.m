//
//  DBBaseViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBBaseViewModel.h"

NSString *const DBBurgerButtonPressedNotification = @"burgerButtonPressedNotification";

@interface DBBaseViewController ()

@property (nonatomic, weak) DBBaseViewModel *viewModel;

@end

@implementation DBBaseViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder: aDecoder];
	if(self)
	{
		DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
		self.viewModel = (DBBaseViewModel *)[factory baseViewModel];
	}
	return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(burgerButtonPressedNotifcationHandler:)
												 name: DBBurgerButtonPressedNotification
											   object: nil];
	
	[self addSwipeGesutre];
}

- (void) addSwipeGesutre
{
	UISwipeGestureRecognizer *swipeGestureRecoginzer =
	[[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(startDragging:)];
	swipeGestureRecoginzer.direction = (UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight);
	
	[self.containerView addGestureRecognizer: swipeGestureRecoginzer];
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
		if(newX < 0)
		{
			newX = 0;
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
	ViewEasingFunctionPointerType ease = BackEaseOut;
	
	if(fabs(speed) > 300)
	{
		positionToAnimateTo = [self positionWithVelocity: speed];
		ease = CircularEaseOut;
	}
	
	CGFloat xPoints = CGRectGetWidth(self.groupTableView.frame);
	NSTimeInterval duration = fabs( xPoints / speed );
	
	if(duration > 0.4f)
	{
		duration = 0.4f;
	}
	[self animateView: self.containerView toPosition: positionToAnimateTo withDuration: duration withEase: ease];
}

- (CGPoint) positionWithVelocity: (CGFloat) velocity
{
	CGPoint positionToAnimateTo = CGPointZero;
	if(velocity > 0)
	{
		positionToAnimateTo = CGPointMake(CGRectGetWidth(self.groupTableView.frame), 0.0);
	}
	return positionToAnimateTo;
}

- (CGPoint) positionWithPosition: (CGPoint) position
{
	CGPoint positionToAnimateTo = CGPointZero;
	CGSize slideWindowWidth = self.groupTableView.frame.size;
	
	if(position.x > slideWindowWidth.width * 0.5)
	{
		positionToAnimateTo = CGPointMake(CGRectGetWidth(self.groupTableView.frame), 0.0);
	}
	return positionToAnimateTo;
}

- (BOOL) gestureRecognizer: (UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) burgerButtonPressedNotifcationHandler: (NSNotification *) notification
{
	[self animateView: self.containerView
		   toPosition: CGPointMake(CGRectGetWidth(self.groupTableView.frame), 0.0)
		 withDuration: 0.4f
			 withEase: CircularEaseOut];
}

- (void) animateView: (UIView *) view toPosition: (CGPoint) position withDuration: (NSTimeInterval) duration withEase: (ViewEasingFunctionPointerType) ease
{
	[UIView animateWithDuration: duration animations:^{
		
		[view setEasingFunction: ease forKeyPath:@"frame"];
		
		view.frame = ({
			CGRect frame = view.frame;
			frame.origin = position;
			frame;
		});
	}];
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self
													name: DBBurgerButtonPressedNotification
												  object: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
