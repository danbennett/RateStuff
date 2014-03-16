//
//  DBToolTipCell.m
//  Auditr
//
//  Created by Daniel Bennett on 15/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBToolTipCell.h"

@interface DBToolTipCell()

@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIView *highlightedView;

@end

@implementation DBToolTipCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[[NSBundle mainBundle] loadNibNamed: @"TooltipCell" owner: self options: nil];
		self.view.frame = ({
			CGRect cellFrame = frame;
			cellFrame.origin.x = 0.0f;
			cellFrame.origin.y = 0.0f;
			cellFrame;
		});
		[self addSubview: self.view];
    }
    return self;
}

@end
