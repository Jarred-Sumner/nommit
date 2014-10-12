//
//  NMDeliveryAvatarsTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMColors.h"


@implementation NMDeliveryAvatarsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    
    self.contentView.layer.masksToBounds = NO;
    self.layer.masksToBounds = NO;
    
    [self setupAvatarSeller];
    [self setupAvatarPrice];
    [self addBorder];
    [self setupUpdateLabel];
    
    return self;
}

#pragma mark - Avatar Image View
- (void)setupCourierAvatarWithProfileId:(NSString *)profileId
{
    _avatarCourier = [[FBProfilePictureView alloc] initWithProfileID:profileId pictureCropping:FBProfilePictureCroppingSquare];
    _avatarCourier.frame = CGRectMake(20, -35, 80, 80);
    _avatarCourier.layer.cornerRadius = 80 / 2;
    _avatarCourier.layer.masksToBounds = YES;
    _avatarCourier.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_avatarCourier];
    
    UIImageView *avatarBorder = [[UIImageView alloc] initWithFrame:CGRectMake(14, -39, 90, 90)];
    avatarBorder.image = [UIImage imageNamed:@"AvatarBorder"];
    
    [self.contentView addSubview:avatarBorder];
}

- (void)setupAvatarSeller
{
    _avatarSeller = [self createCircleAvatarWithFrame:CGRectMake(121, -35, 80, 80)];
    [_avatarSeller setImage:[UIImage imageNamed:@"TriDeltaBadge"]];
    [self.contentView addSubview:_avatarSeller];
    
    UIImageView *avatarBorder = [[UIImageView alloc] initWithFrame:CGRectMake(121 -6, -39, 90, 90)];
    avatarBorder.image = [UIImage imageNamed:@"AvatarBorder"];
    
    [self.contentView addSubview:avatarBorder];
}

- (void)setupAvatarPrice
{
    _avatarPrice = [self createCircleAvatarWithFrame:CGRectMake(222, -35, 80, 80)];
    _avatarPrice.backgroundColor = [NMColors mainColor];
    [self.contentView addSubview:_avatarPrice];
    
    UIImageView *avatarBorder = [[UIImageView alloc] initWithFrame:CGRectMake(222 -6, -39, 90, 90)];
    avatarBorder.image = [UIImage imageNamed:@"AvatarBorder"];
    
    [self.contentView addSubview:avatarBorder];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:@"Avenir" size:28];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_priceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_avatarPrice addSubview:_priceLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_priceLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel) ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_priceLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel) ]];
}

- (void)setupUpdateLabel {
    _updateLabel = [[TTTAttributedLabel alloc] init];
    _updateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _updateLabel.textColor = UIColorFromRGB(0x3c3c3c);
    _updateLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13.0f];
    _updateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _updateLabel.numberOfLines = 0;
    [self.contentView addSubview:_updateLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_updateLabel]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_updateLabel) ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[_updateLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_updateLabel) ]];
}

- (UIImageView *)createCircleAvatarWithFrame:(CGRect)frame {
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:frame];
    
    avatar.layer.cornerRadius = CGRectGetWidth(frame) / 2;
    avatar.layer.masksToBounds = YES;
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    
    return avatar;
}

- (void)addBorder {
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}

@end
