//
//  DBAreaTableHeaderView.m
//  Auditr
//
//  Created by Daniel Bennett on 07/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaTableHeaderView.h"

@interface DBAreaTableHeaderView()

@property (nonatomic, strong) IBOutlet UILabel *areasLabel;

@end

@implementation DBAreaTableHeaderView

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self styleLabel];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.areasLabel.font.pointSize];
	[self.areasLabel setFont: font];
}

@end
