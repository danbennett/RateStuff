//
//  DBToolTipCollectionView.m
//  Auditr
//
//  Created by Daniel Bennett on 16/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DBToolTipCollectionView.h"

@implementation DBToolTipCollectionView

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
	self = [super initWithFrame: frame collectionViewLayout: layout];
	if (self)
	{
		self.layer.cornerRadius = 5.0f;
	}
	return self;
}

- (void) awakeFromNib
{
	[super awakeFromNib];
	self.layer.cornerRadius = 5.0f;
}

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
