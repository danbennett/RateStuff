//
//  DBAreaTableViewCell.h
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBAreaViewModel;

@interface DBAreaTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isInFocus;
@property (nonatomic, weak) DBAreaViewModel *viewModel;

@end
