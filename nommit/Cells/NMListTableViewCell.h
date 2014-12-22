//
//  NMLocationTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *accessoryLabel;
@property (strong, nonatomic) UILabel *textLabel;

@end
