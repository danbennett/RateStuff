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

@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *arrowConstraint;
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
	self.view.frame = CGRectMake(0.0f, position.y - self.view.frame.size.height, parent.bounds.size.width, self.view.frame.size.height);
	self.arrowConstraint.constant = (position.x - (self.arrowImageView.frame.size.width * 0.5f));
	
	UIButton *closeButton = [[UIButton alloc] initWithFrame: parent.bounds];
	[closeButton addTarget: self action: @selector(closeButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
	[parent addSubview: closeButton];
	
	[parent addSubview: self];
	
	if (animated)
	{
		self.alpha = 0.0f;
		[self fadeTo: 1 withCompletion: NULL];
	}
}

- (void) closeButtonTapped: (UIButton *) sender
{
	@weakify(self);
	[self fadeTo: 0 withCompletion:^(BOOL finished) {
		@strongify(self);
		[self removeFromSuperview];
		[sender removeFromSuperview];
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

#pragma mark - Animation.

- (void) fadeTo: (CGFloat) alphaValue withCompletion: (void (^)(BOOL finished)) completion
{
	[self animateToOpacity: alphaValue withDuration: 0.22f withCompletion: completion];
}

@end
