//
//  UIView+Animations.m
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)

- (void) animateToPosition: (CGPoint) position withDuration: (NSTimeInterval) duration withEase: (ViewEasingFunctionPointerType) ease
{
	@weakify(self);
	[UIView animateWithDuration: duration animations:^{
	
		@strongify(self);
		[self setEasingFunction: ease forKeyPath:@"frame"];
		
		self.frame = ({
			CGRect frame = self.frame;
			frame.origin = position;
			frame;
		});
	}];
}

- (void) animateToOpacity: (CGFloat) alpha withDuration: (NSTimeInterval) duration
{
	@weakify(self);
	[UIView animateWithDuration: duration animations:^{
	
		@strongify(self);
		self.alpha = alpha;
		
	}];
}

@end
