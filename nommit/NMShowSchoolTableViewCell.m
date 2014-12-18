//
//  NMShowSchoolCell.m
//  nommit
//
//  Created by Jarred Sumner on 12/18/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMShowSchoolTableViewCell.h"
#import <FontAwesomeKit.h>
#import <TTTAttributedLabel.h>

@interface NMShowSchoolTableViewCell ()

@property (nonatomic, strong) TTTAttributedLabel *editIconLabel;

@end

@implementation NMShowSchoolTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor whiteColor];
    container.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
    container.layer.borderWidth = 1.0f;
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _schoolLabel = [[UILabel alloc] init];
    _schoolLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _schoolLabel.textColor = UIColorFromRGB(0x474747);
    _schoolLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    
    [container addSubview:_schoolLabel];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_schoolLabel]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_schoolLabel)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_schoolLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_schoolLabel)]];

    
    [self.contentView addSubview:container];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[container]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(container)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[container]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(container)]];

    FAKFontAwesome *icon = [FAKFontAwesome editIconWithSize:15.f];
    [icon addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x474747)];
    
    _editIconLabel = [[TTTAttributedLabel alloc] init];
    _editIconLabel.attributedText = icon.attributedString;
    _editIconLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:_editIconLabel];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_editIconLabel]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_editIconLabel)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_editIconLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_editIconLabel)]];

    
    
    return self;
}

@end
