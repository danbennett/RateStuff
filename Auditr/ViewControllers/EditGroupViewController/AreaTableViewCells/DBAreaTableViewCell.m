//
//  DBAreaTableViewCell.m
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaTableViewCell.h"
#import "DBAreaViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBAreaTableViewCell()

@property (nonatomic, strong) IBOutlet UITextField *areaNameTextField;
@property (nonatomic, strong) IBOutlet UILabel *areaNameLabel;

@end

@implementation DBAreaTableViewCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	[self applyBindings];
}

- (void) applyBindings
{
	@weakify(self);
	[[RACObserve(self, viewModel) distinctUntilChanged] subscribeNext:^(DBAreaViewModel *viewModel) {
	
		@strongify(self);
		[self.areaNameLabel setText: viewModel.areaName];
		
		[self applyAreaBindings];
		
	}];
	
	[RACObserve(self, isInFocus) subscribeNext:^(NSNumber *isSelected) {
		@strongify(self);
		if ([isSelected boolValue])
		{
			[self.areaNameTextField setHidden: NO];
			[self.areaNameTextField becomeFirstResponder];
		}
		else
		{
			[self.areaNameTextField setHidden: YES];
			[self.areaNameTextField resignFirstResponder];
		}
	}];
}

- (void) applyAreaBindings
{
	
}

@end
