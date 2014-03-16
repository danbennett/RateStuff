//
//  UIView+Animations.h
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

- (void) animateToPosition: (CGPoint) position
			  withDuration: (NSTimeInterval) duration
				  withEase: (UIViewAnimationOptions) ease
			withCompletion: (void (^)(BOOL finished))completion;

- (void) animateToOpacity: (CGFloat) alpha withDuration: (NSTimeInterval) duration withCompletion: (void (^)(BOOL finished)) completion;

- (void) animateFrameWithBounce: (CGRect) frame
				   withDuration: (NSTimeInterval) duration
					   withEase: (UIViewAnimationOptions) ease
				 withCompletion: (void (^)(BOOL finished))completion;

- (void) animateWithBounce: (void(^)()) animation
			  withDuration: (NSTimeInterval) duration
				  withEase: (UIViewAnimationOptions) ease
			withCompletion: (void (^)(BOOL finished)) completion;
@end
