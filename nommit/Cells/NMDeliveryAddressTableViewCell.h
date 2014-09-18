//
//  NMDeliveryAddressTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMDeliveryAddressTableViewCell;

@interface NMDeliveryAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) UILabel *estimatedTimeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end


