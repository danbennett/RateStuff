//
//  DBItemTableHeaderView.m
//  Auditr
//
//  Created by Daniel Bennett on 08/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemTableHeaderView.h"

@interface DBItemTableHeaderView()

@property (nonatomic, strong) IBOutlet UILabel *itemsLabel;

@end

@implementation DBItemTableHeaderView

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self styleLabel];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.itemsLabel.font.pointSize];
	[self.itemsLabel setFont: font];
}

@end
