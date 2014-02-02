//
//  UIView+Animations.h
//  Auditr
//
//  Created by Daniel Bennett on 31/01/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

- (void) animateToPosition: (CGPoint) position withDuration: (NSTimeInterval) duration withEase: (UIViewAnimationOptions) ease;
- (void) animateToOpacity: (CGFloat) alpha withDuration: (NSTimeInterval) duration;

@end
