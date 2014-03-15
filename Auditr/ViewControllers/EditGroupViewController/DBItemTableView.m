//
//  DBItemTableView.m
//  Auditr
//
//  Created by Daniel Bennett on 08/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemTableView.h"

@implementation DBItemTableView

- (CGSize) intrinsicContentSize
{
	[self layoutIfNeeded];
	return CGSizeMake(UIViewNoIntrinsicMetric, self.contentSize.height);
}

- (void)reloadData
{
    [super reloadData];
    [self invalidateIntrinsicContentSize];
}

- (void)endUpdates
{
    [super endUpdates];
	self.contentSize = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)];
    [self invalidateIntrinsicContentSize];
}

@end
