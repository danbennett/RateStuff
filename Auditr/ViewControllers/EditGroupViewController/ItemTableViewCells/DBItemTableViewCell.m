//
//  DBItemTableViewCell.m
//  Auditr
//
//  Created by Daniel Bennett on 08/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBItemTableViewCell.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import "DBItemViewModel.h"

@interface DBItemTableViewCell()

@property (nonatomic, strong) NSMutableArray *disposables;
@property (nonatomic, strong) IBOutlet UILabel *itemNameLabel;

@end

static NSString *const DBDefaultItemName = @"New item";

@implementation DBItemTableViewCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	
	self.disposables = [NSMutableArray array];
	[self styleLabel];
	[self applyBindings];
	
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: self.itemNameLabel.font.pointSize];
	[self.itemNameLabel setFont: font];
}

- (void) applyBindings
{
	@weakify(self);
	[[RACObserve(self, viewModel) distinctUntilChanged] subscribeNext:^(DBItemViewModel *viewModel) {
		
		@strongify(self);
		[self.itemNameLabel setText: viewModel.itemName];
		[self.itemNameTextField setText: viewModel.itemName];
		
		[self applyItemBindings];
		
	}];
	
	[RACObserve(self, isInFocus) subscribeNext:^(NSNumber *isSelected) {
		@strongify(self);
		if ([isSelected boolValue])
		{
			[self.itemNameTextField setHidden: NO];
			[self.itemNameTextField performSelector: @selector(becomeFirstResponder) withObject: nil afterDelay: 0.2f];
		}
		else
		{
			[self.itemNameTextField setHidden: YES];
			[self.itemNameTextField resignFirstResponder];
		}
	}];
}

- (void) applyItemBindings
{
	@weakify(self);
	RACDisposable *disposable = [[self.itemNameTextField.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString *newName) {
		
		@strongify(self);
		self.viewModel.itemName = newName;
		self.itemNameLabel.text = newName;
		if (newName.length == 0)
		{
			self.viewModel.itemName = DBDefaultItemName;
			self.itemNameLabel.text = DBDefaultItemName;
		}
	}];
	
	[self.disposables addObject: disposable];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if ([self.delegate respondsToSelector: @selector(itemTableViewCellDidEndEditing:)])
	{
		[self.delegate itemTableViewCellDidEndEditing: self];
	}
	return YES;
}

- (void) prepareForReuse
{
	[super prepareForReuse];
	[self.disposables makeObjectsPerformSelector: @selector(dispose)];
}

@end
