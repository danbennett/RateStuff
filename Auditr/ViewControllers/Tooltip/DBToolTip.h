//
//  DBToolTip.h
//  Auditr
//
//  Created by Daniel Bennett on 15/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DBToolTipDataSource;
@protocol DBToolTipDelegate;

@interface DBToolTip : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) id<DBToolTipDataSource> dataSource;
@property (nonatomic, assign) id<DBToolTipDelegate> delegate;

- (id) initWithButtons: (NSArray *) buttons;
- (void) showInView: (UIView *) parent atPoint: (CGPoint) position animated: (BOOL) animated;

@end

@protocol DBToolTipDataSource <NSObject>

@required
- (NSInteger) numberOfButtons: (DBToolTip *) toolTip;

@optional
- (UIImage *) toolTip: (DBToolTip *) tooltip imageForButtonAtIndex: (NSInteger) index;

@end

@protocol DBToolTipDelegate <NSObject>

- (void) toolTipDidSelectButtonAtIndex: (NSInteger) index;

@end