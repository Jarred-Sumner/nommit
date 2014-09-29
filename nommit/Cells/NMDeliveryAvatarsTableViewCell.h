//
//  NMDeliveryAvatarsTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMDeliveryAvatarsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarCourier;

@property (nonatomic, strong) UIImageView *avatarSeller;

@property (nonatomic, strong) UIImageView *avatarPrice;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *updateLabel;


@end
