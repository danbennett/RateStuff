//
//  DBListAccessoryView.m
//  Auditr
//
//  Created by Daniel Bennett on 16/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBListAccessoryView.h"

@implementation DBListAccessoryView

+ (id) loadFromNib
{
	return [[NSBundle mainBundle] loadNibNamed: @"ListInputAccessoryView" owner: nil options: nil][0];
}

- (IBAction) cameraTapped: (UIButton *) sender
{
	if ([self.textViewDelegate respondsToSelector: @selector(listAccessoryDidPressCamera:)])
	{
		[self.textViewDelegate listAccessoryDidPressCamera: self];
	}
}

- (IBAction) deleteTapped: (UIButton *) sender
{
	if([self.textViewDelegate respondsToSelector: @selector(listAccessoryDidPressDelete:)])
	{
		[self.textViewDelegate listAccessoryDidPressDelete: self];
	}
}

- (IBAction) doneTapped: (UIButton *) sender
{
	if ([self.textViewDelegate respondsToSelector: @selector(listAccessoryDidPressDone:)])
	{
		[self.textViewDelegate listAccessoryDidPressDone: self];
	}
}

- (void) awakeFromNib
{
	[super awakeFromNib];
}

@end
