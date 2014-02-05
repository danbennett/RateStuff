//
//  DBGroupTableViewCell.m
//  Auditr
//
//  Created by Daniel Bennett on 04/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBGroupTableViewCell.h"
#import "DBGroupViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <QuartzCore/QuartzCore.h>

@interface DBGroupTableViewCell()

@property (nonatomic, strong) NSMutableArray *disposables;
@property (nonatomic, strong) IBOutlet UILabel *groupNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *imageHolderView;

@end

@implementation DBGroupTableViewCell

- (void) awakeFromNib
{
	[super awakeFromNib];
	self.disposables = [NSMutableArray array];
	[self styleLabel];
	[self styleImageView];
	[self applyBindings];
}

- (void) styleLabel
{
	UIFont *font = [UIFont fontWithName:@"Museo Sans" size: 15];
	[self.groupNameLabel setFont: font];
}

- (void) styleImageView
{
	self.imageView.layer.cornerRadius = self.imageView.frame.size.width * 0.5;
	self.imageHolderView.layer.cornerRadius = self.imageHolderView.frame.size.width * 0.5;
	[self.imageHolderView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
}

- (void) applyBindings
{
	@weakify(self);
	[RACObserve(self, viewModel) subscribeNext:^(DBGroupViewModel *viewModel) {
		
		@strongify(self);
		[self.groupNameLabel setText: viewModel.groupName];
		
		if (viewModel != nil)
		{
			[self applyGroupBindings];
		}
		
	}];
}

- (void) applyGroupBindings
{
	@weakify(self);
	RACDisposable *disposable = [[RACObserve(self.viewModel, groupName) distinctUntilChanged] subscribeNext:^(NSString *newName) {
		
		@strongify(self);
		self.groupNameLabel.text = newName;
		
	}];
	
	[self.disposables addObject: disposable];
}

- (void) prepareForReuse
{
	[super prepareForReuse];
	[self.disposables makeObjectsPerformSelector: @selector(dispose)];
}

@end
