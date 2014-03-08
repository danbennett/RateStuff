//
//  DBItemTableFooterView.m
//  Auditr
//
//  Created by Daniel Bennett on 08/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemTableFooterView.h"

@interface DBItemTableFooterView()

@property (nonatomic, strong) IBOutlet UILabel *addItemLabel;

@end

@implementation DBItemTableFooterView

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self styleLabel];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.addItemLabel.font.pointSize];
	[self.addItemLabel setFont: font];
}

@end
