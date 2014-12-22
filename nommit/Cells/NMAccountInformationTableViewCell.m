//
//  NMAccountInformationTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMAccountInformationTableViewCell.h"

@implementation NMAccountInformationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        [self setupAvatar];
        [self setupNameLabel];
        [self setupEmailLabel];
        [self setupPhoneLabel];
    }
    return self;
}

- (void)setupAvatar
{
    _avatar = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(24, 15, 53, 53)];
    _avatar.layer.cornerRadius = CGRectGetWidth(_avatar.bounds) / 2;
    _avatar.layer.masksToBounds = YES;
    [self.contentView addSubview:_avatar];
}

- (void)setupNameLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = UIColorFromRGB(0x5F5F5F);
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:13];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_nameLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
}

- (void)setupEmailLabel
{
    _emailLabel = [[UILabel alloc] init];
    _emailLabel.textColor = UIColorFromRGB(0x5F5F5F);
    _emailLabel.font = [UIFont fontWithName:@"Avenir" size:13];
    _emailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_emailLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[_emailLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emailLabel)]];
}

- (void)setupPhoneLabel
{
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = UIColorFromRGB(0x5F5F5F);
    _phoneLabel.font = [UIFont fontWithName:@"Avenir" size:13];
    _phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_phoneLabel];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[_phoneLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_phoneLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_nameLabel]-1-[_emailLabel]-1-[_phoneLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel, _phoneLabel, _emailLabel)]];
}


@end
