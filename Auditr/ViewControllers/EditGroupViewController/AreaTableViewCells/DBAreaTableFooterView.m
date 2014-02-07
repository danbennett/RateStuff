//
//  DBAreaTableFooterView.m
//  Auditr
//
//  Created by Daniel Bennett on 07/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaTableFooterView.h"

@interface DBAreaTableFooterView()

@property (nonatomic, strong) IBOutlet UILabel *addAreaLabel;

@end

@implementation DBAreaTableFooterView

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self styleLabel];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.addAreaLabel.font.pointSize];
	[self.addAreaLabel setFont: font];
}

@end
