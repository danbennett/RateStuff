//
//  DBToolTipCell.m
//  Auditr
//
//  Created by Daniel Bennett on 15/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBToolTipCell.h"
#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

@interface DBToolTipCell()

@property (nonatomic, strong) IBOutlet UIView *highlightedView;

@end

@implementation DBToolTipCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self.highlightedView setAlpha: 0.0f];
	self.highlightedView.layer.cornerRadius = 2.0f;
}

- (void) setHighlighted:(BOOL)highlighted
{
	[super setHighlighted: highlighted];
	if (highlighted)
	{
		[self.highlightedView setAlpha: 1.0f];
	}
	else
	{
		[self.highlightedView animateToOpacity: 0.0f withDuration: 0.2f withCompletion: NULL];
	}
}

@end
