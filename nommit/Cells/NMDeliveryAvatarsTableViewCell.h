//
//  NMDeliveryAvatarsTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>

@interface NMDeliveryAvatarsTableViewCell : UITableViewCell

@property (nonatomic, strong) FBProfilePictureView *avatarCourier;

@property (nonatomic, strong) UIImageView *avatarSeller;

@property (nonatomic, strong) UIImageView *avatarPrice;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) TTTAttributedLabel *updateLabel;

- (void)setupCourierAvatarWithProfileId:(NSString *)profileId;

@end
