//
//  DBEditGroupViewController.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAreaTableViewCell.h"
#import "DBItemTableViewCell.h"
#import "DBToolTip.h"
@class DBGroupViewModel;
@protocol DBEditGroupViewControllerDelegate;

@interface DBEditGroupViewController : UIViewController <UIBarPositioningDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, DBItemTableViewCellDelegate, DBToolTipDelegate>

@property (nonatomic, weak) DBGroupViewModel *viewModel;
@property (nonatomic, assign) id<DBEditGroupViewControllerDelegate> delegate;

@end

@protocol DBEditGroupViewControllerDelegate <NSObject>

@required
- (void) editGroupViewControllerDidCancel: (DBEditGroupViewController *) viewController;
- (void) editGroupViewControllerDidSave:(DBEditGroupViewController *)viewController;

@end
