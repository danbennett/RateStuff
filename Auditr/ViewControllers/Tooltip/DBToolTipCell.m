//
//  DBToolTipCell.m
//  Auditr
//
//  Created by Daniel Bennett on 15/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBToolTipCell.h"

@interface DBToolTipCell()

@property (nonatomic, strong) IBOutlet UIView *highlightedView;

@end

@implementation DBToolTipCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self.highlightedView setHidden: YES];
}

- (void) setHighlighted:(BOOL)highlighted
{
	[super setHighlighted: highlighted];
	[self.highlightedView setHidden: !highlighted];
}

@end
