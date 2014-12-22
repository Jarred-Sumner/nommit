//
//  NMDeliveryAvatarsTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMColors.h"

@interface NMDeliveryAvatarsTableViewCell ()

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
    
    [self setupAvatars];
    [self addBorder];
    [self setupUpdateLabel];
    
    return self;
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

@end
