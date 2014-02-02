//
//  DBAreaTableViewCell.m
//  Auditr
//
//  Created by Daniel Bennett on 02/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBAreaTableViewCell.h"

@interface DBAreaTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *areaNameLabel;

@end

@implementation DBAreaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
