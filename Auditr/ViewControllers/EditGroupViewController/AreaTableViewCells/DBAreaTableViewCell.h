//
//  DBAreaTableViewCell.h
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBAreaViewModel;
@protocol DBAreaTableViewCellDelegate;

@interface DBAreaTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isInFocus;
@property (nonatomic, weak) DBAreaViewModel *viewModel;
@property (nonatomic, assign) id<DBAreaTableViewCellDelegate> delegate;

@end

@protocol DBAreaTableViewCellDelegate <NSObject>

@optional
- (void) areaTableViewCellDidEndEditing: (DBAreaTableViewCell *) cell;

@end