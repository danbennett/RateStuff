//
//  DBBaseViewController.h
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBEditGroupViewController.h"
@protocol DBGroupTableViewCellDelegate;
@protocol DBEditGroupViewControllerDelegate;

extern NSString *const DBBurgerButtonPressedNotification;
extern NSString *const DBNewGroupPressedNotification;

@interface DBBaseViewController : UIViewController <UISearchBarDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, DBEditGroupViewControllerDelegate, UIGestureRecognizerDelegate, DBGroupTableViewCellDelegate>


@end
