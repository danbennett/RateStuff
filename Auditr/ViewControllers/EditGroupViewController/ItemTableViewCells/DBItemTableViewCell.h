//
//  DBItemTableViewCell.h
//  Auditr
//
//  Created by Daniel Bennett on 08/03/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBItemViewModel;
@protocol DBItemTableViewCellDelegate;

@interface DBItemTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *itemNameTextField;
@property (nonatomic, weak) DBItemViewModel *viewModel;
@property (nonatomic, assign) BOOL isInFocus;
@property (nonatomic, assign) id<DBItemTableViewCellDelegate> delegate;

@end

@protocol DBItemTableViewCellDelegate <NSObject>

@optional
- (void) itemTableViewCellDidEndEditing: (DBItemTableViewCell *) cell;

@end