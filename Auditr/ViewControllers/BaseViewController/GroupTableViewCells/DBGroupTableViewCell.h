//
//  DBGroupTableViewCell.h
//  Auditr
//
//  Created by Daniel Bennett on 04/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBGroupViewModel;
@protocol DBGroupTableViewCellDelegate;

@interface DBGroupTableViewCell : UITableViewCell

@property (nonatomic, weak) DBGroupViewModel *viewModel;
@property (nonatomic, assign) id<DBGroupTableViewCellDelegate> delegate;

@end

@protocol DBGroupTableViewCellDelegate <NSObject>

@optional
- (void) groupCellDidTapEdit: (DBGroupTableViewCell *) cell;

@end
