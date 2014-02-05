//
//  DBGroupTableFooterView.m
//  Auditr
//
//  Created by Daniel Bennett on 04/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBGroupTableFooterView.h"

@interface DBGroupTableFooterView()

@property (nonatomic, strong) IBOutlet UILabel *label;

@end

@implementation DBGroupTableFooterView

- (void) awakeFromNib
{
	[super awakeFromNib];
	
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: 15];
	[self.label setFont: font];
}

@end
