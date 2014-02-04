//
//  DBEditGroupViewController.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBGroupViewModel;
@protocol DBAreaTableViewCellDelegate;

@interface DBEditGroupViewController : UIViewController <UIBarPositioningDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, DBAreaTableViewCellDelegate>

@property (nonatomic, strong) DBGroupViewModel *viewModel;

@end
