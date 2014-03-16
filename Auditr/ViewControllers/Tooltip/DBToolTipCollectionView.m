//
//  DBToolTipCollectionView.m
//  Auditr
//
//  Created by Daniel Bennett on 16/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBToolTipCollectionView.h"

@implementation DBToolTipCollectionView

- (CGSize) intrinsicContentSize
{
	[self layoutIfNeeded];
	return CGSizeMake(self.contentSize.width, UIViewNoIntrinsicMetric);
}

- (void)reloadData
{
    [super reloadData];
	self.contentSize = [self sizeThatFits: CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds))];
    [self invalidateIntrinsicContentSize];
}

@end
