//
//  NMLogoutButtonCell.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLogoutButtonCell.h"

@implementation NMLogoutButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logoutButton.backgroundColor = [NMColors mainColor];
    _logoutButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_logoutButton];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_logoutButton]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoutButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_logoutButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoutButton)]];
    
    return self;
}

@end
