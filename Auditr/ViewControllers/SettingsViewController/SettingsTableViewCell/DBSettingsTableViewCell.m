//
//  DBSettingsTableViewCell.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsTableViewCell.h"

@interface DBSettingsTableViewCell()

@end

@implementation DBSettingsTableViewCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	
	[self styleLabels];
}

#pragma mark - Style labels.

- (void) styleLabels
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.valueLabel.font.pointSize];
	[self.valueLabel setFont: font];
}

@end
