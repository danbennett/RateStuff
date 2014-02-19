//
//  DBSettingsTableViewCell.h
//  Auditr
//
//  Created by Daniel Bennett on 12/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBProfileViewModel;

@interface DBSettingsTableViewCell : UITableViewCell

@property (nonatomic, weak) DBProfileViewModel *viewModel;
@property (nonatomic, strong) IBOutlet UILabel *valueLabel;

@end
