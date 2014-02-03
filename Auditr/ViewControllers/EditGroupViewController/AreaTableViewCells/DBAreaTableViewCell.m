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

@property (nonatomic, strong) NSMutableArray *disposables;
@property (nonatomic, strong) IBOutlet UITextField *areaNameTextField;
@property (nonatomic, strong) IBOutlet UILabel *areaNameLabel;

@end

static NSString *const DBDefaultAreaName = @"New ratable area";

@implementation DBAreaTableViewCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	self.disposables = [NSMutableArray array];
	[self applyBindings];
}

- (void) applyBindings
{
	@weakify(self);
	[[RACObserve(self, viewModel) distinctUntilChanged] subscribeNext:^(DBAreaViewModel *viewModel) {
	
		@strongify(self);
		[self.areaNameLabel setText: viewModel.name];
		[self.areaNameTextField setText: viewModel.name];
		
		[self applyAreaBindings];
		
	}];
	
	[RACObserve(self, isInFocus) subscribeNext:^(NSNumber *isSelected) {
		@strongify(self);
		if ([isSelected boolValue])
		{
			[self.areaNameTextField setHidden: NO];
			[self.areaNameTextField performSelector: @selector(becomeFirstResponder) withObject: nil afterDelay: 0.2f];
//			[self.areaNameTextField becomeFirstResponder];
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
	@weakify(self);
	RACDisposable *disposable = [[self.areaNameTextField.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString *newName) {
	
		@strongify(self);
		self.viewModel.name = newName;
		self.areaNameLabel.text = newName;
		if (newName.length == 0)
		{
			self.viewModel.name = DBDefaultAreaName;
			self.areaNameLabel.text = DBDefaultAreaName;
		}
	}];
	
	[self.disposables addObject: disposable];
}

- (void) prepareForReuse
{
	[super prepareForReuse];
	[self.disposables makeObjectsPerformSelector: @selector(dispose)];
}

@end
