//
//  DBListAccessoryView.h
//  Auditr
//
//  Created by Daniel Bennett on 16/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DBListAccessoryViewDelegate;

@interface DBListAccessoryView : UIToolbar

@property (nonatomic, assign) id<DBListAccessoryViewDelegate> textViewDelegate;

+ (id) loadFromNib;

@end

@protocol DBListAccessoryViewDelegate <NSObject>

@optional
- (void) listAccessoryDidPressDelete: (DBListAccessoryView *) view;
- (void) listAccessoryDidPressCamera: (DBListAccessoryView *) view;
- (void) listAccessoryDidPressDone: (DBListAccessoryView *) view;

@end
