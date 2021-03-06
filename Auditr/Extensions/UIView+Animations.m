//
//  UIView+Animations.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "UIView+Animations.h"
#import <ReactiveCocoa/RACEXTScope.h>

@implementation UIView (Animations)

- (void) animateToPosition: (CGPoint) position withDuration: (NSTimeInterval) duration withEase: (UIViewAnimationOptions) ease withCompletion: (void (^)(BOOL finished))completion
{
	@weakify(self);
	[UIView animateWithDuration: duration delay:0.0 options: ease animations:^{
	
		@strongify(self);
		self.frame = ({
			CGRect frame = self.frame;
			frame.origin = position;
			frame;
		});
	} completion: completion];
}

- (void) animateFrameWithBounce: (CGRect) frame withDuration: (NSTimeInterval) duration withEase: (UIViewAnimationOptions) ease withCompletion: (void (^)(BOOL finished))completion
{
	@weakify(self);

	[UIView animateWithDuration: duration
						  delay: 0.0f
		 usingSpringWithDamping: 0.8f
		  initialSpringVelocity: 0.2f
						options: ease
					 animations:^{

		@strongify(self);
		self.frame = frame;
		
	} completion: completion];
}

- (void) animateWithBounce: (void(^)()) animation
			  withDuration: (NSTimeInterval) duration
				  withEase: (UIViewAnimationOptions) ease
			withCompletion: (void (^)(BOOL finished)) completion
{
	[UIView animateWithDuration: duration
						  delay: 0.0f
		 usingSpringWithDamping: 0.8f
		  initialSpringVelocity: 0.2f
						options: ease
					 animations: animation
					 completion: completion];
}

- (void) animateToOpacity: (CGFloat) alpha withDuration: (NSTimeInterval) duration withCompletion: (void (^)(BOOL finished)) completion
{
	@weakify(self);
	[UIView animateWithDuration: duration animations:^{
	
		@strongify(self);
		self.alpha = alpha;
		
	} completion: completion];
}

@end
