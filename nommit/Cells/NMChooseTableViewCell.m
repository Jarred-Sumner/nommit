//
//  NMDeliveryTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/11/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMChooseTableViewCell.h"

@interface NMChooseTableViewCell()

@property (nonatomic, strong) UIImageView *cellBG;

@end

@implementation NMChooseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupCellBG];
        [self setupAvatar];
        [self setupName];
        [self setupSelectedOverlay];
    }
    return self;
}

- (void)setupCellBG {
    _cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeliveryCell"]];
    _cellBG.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_cellBG];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-22-[_cellBG]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cellBG)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_cellBG]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cellBG)]];
}

- (void)setupAvatar {
    _avatar = [[UIImageView alloc] init];
    _avatar.translatesAutoresizingMaskIntoConstraints = NO;
    _avatar.layer.cornerRadius = 53 / 2;
    _avatar.clipsToBounds = YES;
    [_avatar setContentMode:UIViewContentModeScaleAspectFill];
    [_cellBG addSubview:_avatar];
    
    [_cellBG addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-232-[_avatar(53)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
    [_cellBG addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_avatar(53)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
    
    UIImageView *reflection = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Reflection"]];
    reflection.translatesAutoresizingMaskIntoConstraints = NO;
    [_avatar addSubview:reflection];
    [_avatar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[reflection]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(reflection)]];
    [_avatar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[reflection]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(reflection)]];
    
}

- (void)setupName {
    _name = [[UILabel alloc] init];
    _name.translatesAutoresizingMaskIntoConstraints = NO;
    _name.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    _name.textColor = UIColorFromRGB(0x6C6C6C);
    [_cellBG addSubview:_name];
    
    [_cellBG addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[_name]-25-[_avatar]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name, _avatar)]];
    [_cellBG addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_name]-14-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name)]];
    
}

- (void)setupSelectedOverlay {
    _selectedOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeliveryCheckOverlay"]];
    _selectedOverlay.translatesAutoresizingMaskIntoConstraints = NO;
    _selectedOverlay.hidden = YES;
    [_avatar addSubview:_selectedOverlay];
    
    [_avatar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_selectedOverlay(53)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectedOverlay)]];
    [_avatar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_selectedOverlay(53)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectedOverlay)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
