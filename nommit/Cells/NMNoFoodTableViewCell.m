//
//  NMNoFoodTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMNoFoodTableViewCell.h"
#import <FAKFontAwesome.h>

@interface NMNoFoodTableViewCell()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation NMNoFoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        [self setupChefIcon];
        [self setupLabel];
        self.state = NMNoFoodCellStateUnknown;
    }
    return self;
}

- (void)setupChefIcon {
    _topImageView = [[UIImageView alloc] init];
    _topImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _topImageView.image = [UIImage imageNamed:@"ClosedSign"];
    _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_topImageView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-92-[_topImageView]-92-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_topImageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_topImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_topImageView)]];
}

- (void)setupLabel {
    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.font = [UIFont fontWithName:@"Avenir" size:16];
    _label.textColor = UIColorFromRGB(0xB2B2B2);
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 3;
    
    [self.contentView addSubview:_label];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-44-[_label]-44-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topImageView]-20-[_label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label, _topImageView)]];

    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
    _arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _arrowImageView.contentMode = UIViewContentModeCenter;
    
    [self.contentView addSubview:_arrowImageView];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_arrowImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_arrowImageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-18-[_arrowImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label, _arrowImageView)]];
    

}

- (void)setState:(NMNoFoodCellState)state {
    if (state == NMNoFoodCellStateClosed && [[[NMUser currentUser] school] hasHours]) {
        NSDateFormatter *shortFormatter = [[NSDateFormatter alloc] init];
        shortFormatter.dateStyle = NSDateFormatterNoStyle;
        shortFormatter.timeStyle = NSDateFormatterShortStyle;
        
        NSString *fromTime = [shortFormatter stringFromDate:NMUser.currentUser.school.fromHours];
        NSString *toTime = [shortFormatter stringFromDate:NMUser.currentUser.school.toHours];
        _label.text = [NSString stringWithFormat:@"We're closed! Open Weekdays: \n %@ to %@", fromTime, toTime];
        
        
        _arrowImageView.hidden = YES;
    } else {
        _label.text = @"No food available right now, but you can change that!";
        _arrowImageView.hidden = NO;
    }
}
@end
