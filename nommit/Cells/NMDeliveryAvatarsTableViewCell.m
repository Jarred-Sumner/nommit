//
//  NMDeliveryAvatarsTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMColors.h"

#import "NMBadgeView.h"

@interface NMDeliveryAvatarsTableViewCell ()

@property (nonatomic, strong) NMBadgeView *courierBadge;
@property (nonatomic, strong) NMBadgeView *sellerBadge;
@property (nonatomic, strong) NMBadgeView *priceBadge;

@property (nonatomic, strong) UIView *avatarContainerView;

@end

static NSInteger NMCircleAvatarWidth = 80;

@implementation NMDeliveryAvatarsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    
    self.contentView.layer.masksToBounds = NO;
    self.layer.masksToBounds = NO;
    
    [self addBorder];
    [self setupUpdateLabel];
    
    return self;
}


- (void)setupUpdateLabel {
    _updateLabel = [[TTTAttributedLabel alloc] init];
    _updateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _updateLabel.adjustsFontSizeToFitWidth = YES;
    _updateLabel.textColor = UIColorFromRGB(0x3c3c3c);
    _updateLabel.font = [UIFont fontWithName:@"Avenir-Light" size:19.0f];
    _updateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _updateLabel.numberOfLines = 0;
    [self.contentView addSubview:_updateLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_updateLabel]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_updateLabel) ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-55-[_updateLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_updateLabel) ]];
}

- (void)addBorder {
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}

- (void)setProfileID:(NSString *)profileID sellerImageURL:(NSURL *)sellerImageURL price:(NSNumber*)price {
    _courierBadge = [[NMBadgeView alloc] initWithRadius:40 profileID:profileID];
    _sellerBadge = [[NMBadgeView alloc] initWithRadius:40 imageURL:sellerImageURL];
    _priceBadge = [[NMBadgeView alloc] initWithRadius:40 text:[NSString stringWithFormat:@"$%@", price]];
        
    UIView *badges = [[UIView alloc] init];
    badges.contentMode = UIViewContentModeCenter;
    badges.translatesAutoresizingMaskIntoConstraints = NO;
    
    [badges addSubview:_courierBadge];
    [badges addSubview:_sellerBadge];
    [badges addSubview:_priceBadge];
    
    [badges addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_courierBadge]-20-[_sellerBadge]-20-[_priceBadge]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courierBadge, _sellerBadge, _priceBadge)]];
    [badges addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_courierBadge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courierBadge, _sellerBadge, _priceBadge)]];
    [badges addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_sellerBadge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courierBadge, _sellerBadge, _priceBadge)]];
    [badges addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_priceBadge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_courierBadge, _sellerBadge, _priceBadge)]];
    
    
    [self.contentView addSubview:badges];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-40)-[badges]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badges)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:badges attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

}

@end
