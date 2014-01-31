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
	[UIView animateWithDuration: duration animations:^{
		
		[self setEasingFunction: ease forKeyPath:@"frame"];
		
		self.frame = ({
			CGRect frame = self.frame;
			frame.origin = position;
			frame;
		});
	}];
}

@end
