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
#import "UIImage+Scaling.h"

@interface DBGroupTableViewCell()

@property (nonatomic, strong) NSMutableArray *disposables;
@property (nonatomic, strong) IBOutlet UILabel *groupNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;
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
	self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.size.width * 0.5;
	self.thumbnailImageView.clipsToBounds = YES;
	self.imageHolderView.layer.cornerRadius = self.imageHolderView.frame.size.width * 0.5;
	[self.imageHolderView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed:@"imageBackground"]]];
}

- (void) applyBindings
{
	@weakify(self);
	[RACObserve(self, viewModel) subscribeNext:^(DBGroupViewModel *viewModel) {
		
		if (viewModel != nil)
		{
			@strongify(self);
			
			[self dispose];
			
			[self.groupNameLabel setText: viewModel.groupName];
			[self loadThumbnailWithImage: viewModel.thumbnail];

			
			[self applyGroupBindings];
		}
	}];
}

- (void) applyGroupBindings
{
	@weakify(self);
	RACDisposable *groupNameDisposable = [[RACObserve(self.viewModel, groupName) distinctUntilChanged] subscribeNext:^(NSString *newName) {
		
		@strongify(self);
		self.groupNameLabel.text = newName;
		
	}];
	[self.disposables addObject: groupNameDisposable];

	
	RACDisposable *imageDisposable = [[RACObserve(self.viewModel, thumbnail) distinctUntilChanged] subscribeNext:^(UIImage *image) {

		@strongify(self);
		[self loadThumbnailWithImage: image];
		
	}];
	
	[self.disposables addObject: imageDisposable];
}

- (void) loadThumbnailWithImage: (UIImage *) image
{
	[self.thumbnailImageView setImage: image];
	[self setNeedsLayout];
}

- (IBAction) editButtonTapped: (UIButton *) sender
{
	if([self.delegate respondsToSelector: @selector(groupCellDidTapEdit:)])
	{
		[self.delegate groupCellDidTapEdit: self];
	}
}

- (void) prepareForReuse
{
	[super prepareForReuse];
	[self dispose];
}

- (void) dispose
{
	[self.disposables makeObjectsPerformSelector: @selector(dispose)];
	self.disposables = [NSMutableArray array];
}

@end
