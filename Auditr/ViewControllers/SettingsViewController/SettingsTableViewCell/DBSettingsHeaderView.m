//
//  DBSettingsHeaderView.m
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBSettingsHeaderView.h"

@interface DBSettingsHeaderView()

@property (nonatomic, strong) IBOutlet UILabel *headerLabel;

@end

@implementation DBSettingsHeaderView

- (void) awakeFromNib
{
	[super awakeFromNib];
	
	[self styleLabel];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.headerLabel.font.pointSize];
	[self.headerLabel setFont: font];
}

@end
