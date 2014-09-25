//
//  NMFoodOrderTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFoodOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIImageView *profileAvatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderName;


@end
