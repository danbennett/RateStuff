//
//  DBToolTip.m
//  Auditr
//
//  Created by Daniel Bennett on 15/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBToolTip.h"
#import "DBToolTipCell.h"
#import "UIView+Animations.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface DBToolTip()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *arrowConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (nonatomic, strong) NSArray *buttons;

@end

NSString *DBToolTipIdentifier = @"DBToolTipCell";

@implementation DBToolTip

- (id) initWithButtons: (NSArray *) buttons
{
    self = [super init];
    if (self)
	{
		[[NSBundle mainBundle] loadNibNamed: @"Tooltip" owner: self options: nil];
		[self addSubview: self.view];
		
		[self.collectionView registerClass: [DBToolTipCell class] forCellWithReuseIdentifier: DBToolTipIdentifier];
		[self.collectionView registerNib: [UINib nibWithNibName: @"TooltipCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: DBToolTipIdentifier];
		
		self.buttons = buttons;
		
		[self initialise];
    }
    return self;
}

- (id) init
{
	self = [super init];
	if (self)
	{
		[[NSBundle mainBundle] loadNibNamed: @"Tooltip" owner: self options: nil];
		[self addSubview: self.view];
		[self.collectionView registerClass: [DBToolTipCell class] forCellWithReuseIdentifier: DBToolTipIdentifier];
		[self.collectionView registerNib: [UINib nibWithNibName: @"TooltipCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: DBToolTipIdentifier];
		
		NSInteger numberOfButtons = 0;
		if ([self.dataSource respondsToSelector: @selector(numberOfButtons:)])
		{
			numberOfButtons = [self.dataSource numberOfButtons: self];
		}
		
		NSMutableArray *buttons = [NSMutableArray arrayWithCapacity: numberOfButtons];
		for (int i = 0; i < numberOfButtons; i++)
		{
			UIImage *image = [self loadImageForIndex: i];
			[buttons addObject: image];
		}
		self.buttons = [buttons copy];
		
		[self initialise];
	}
	return self;
}

- (void) initialise
{
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView reloadData];
}

- (void) showInView: (UIView *) parent atPoint: (CGPoint) position animated: (BOOL) animated
{
	CGRect frame = CGRectMake(0.0f, position.y - self.view.frame.size.height, parent.bounds.size.width, self.view.frame.size.height);
	self.frame = frame;
	self.view.frame = ({
		CGRect viewFrame = frame;
		viewFrame.origin.x = 0.0f;
		viewFrame.origin.y = 0.0f;
		viewFrame;
	});
	
	if (animated)
	{
		self.alpha = 0.0f;
		[self fadeTo: 1 withCompletion: NULL];
	}

	CGFloat newConstraint = (position.x - (self.arrowImageView.frame.size.width * 0.5f));
	self.arrowConstraint.constant = newConstraint;
	
	if (newConstraint > parent.bounds.size.width * 0.5)
	{
		self.leftConstraint.priority = UILayoutPriorityDefaultHigh;
		self.rightConstraint.priority = UILayoutPriorityRequired;
	}
	else
	{
		self.leftConstraint.priority = UILayoutPriorityRequired;
		self.rightConstraint.priority = UILayoutPriorityDefaultHigh;
		if (self.arrowConstraint.constant > self.leftConstraint.constant + self.collectionView.frame.size.width)
		{
			self.leftConstraint.constant += (self.arrowConstraint.constant - (self.leftConstraint.constant + self.collectionView.frame.size.width));
		}
	}
	
	[self addCloseButtonInView: parent];
	
	[parent addSubview: self];
}

- (void) addCloseButtonInView: (UIView *) view
{
	self.closeButton = [[UIButton alloc] initWithFrame: view.bounds];
	[self.closeButton addTarget: self action: @selector(closeButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
	[view addSubview: self.closeButton];
}

- (IBAction) closeButtonTapped: (UIButton *) sender
{
	@weakify(self);
	[self fadeTo: 0 withCompletion:^(BOOL finished) {
		@strongify(self);
		[self removeFromSuperview];
		[self.closeButton removeFromSuperview];
	}];
}

#pragma mark - collection view datasource.

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.buttons.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	DBToolTipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: DBToolTipIdentifier forIndexPath: indexPath];
	if (indexPath.item < self.buttons.count)
	{
		[cell.imageView setImage: self.buttons[indexPath.item]];
	}
	return cell;
}

#pragma mark - Tooltip datasource.

- (UIImage *) loadImageForIndex: (NSInteger) index
{
	if ([self.dataSource respondsToSelector: @selector(toolTip:imageForButtonAtIndex:)])
	{
		return [self.dataSource	toolTip: self imageForButtonAtIndex: index];
	}
	return nil;
}

#pragma mark - Collection view delegate.

- (BOOL) collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath: (NSIndexPath *)indexPath
{
	if ([self.delegate respondsToSelector: @selector(toolTipDidSelectButtonAtIndex:)])
	{
		[self.delegate toolTipDidSelectButtonAtIndex: indexPath.item];
	}
}

#pragma mark - Animation.

- (void) fadeTo: (CGFloat) alphaValue withCompletion: (void (^)(BOOL finished)) completion
{
	[self animateToOpacity: alphaValue withDuration: 0.22f withCompletion: completion];
}

#pragma mark - Layout.

- (void) layoutSubviews
{
	[super layoutSubviews];
}

@end
