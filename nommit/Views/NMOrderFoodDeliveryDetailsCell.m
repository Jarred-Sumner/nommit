//
//  NMLocationInfoView.m
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodDeliveryDetailsCell.h"
#import "NMColors.h"

@implementation NMOrderFoodDeliveryDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundView.backgroundColor = [NMColors lightGray];
        self.backgroundView.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.backgroundView.layer.borderWidth = 1.0f;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont fontWithName:@"Avenir" size:16.f];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.delegate = self;
        
        [self.contentView addSubview:_textField];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_textField);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_textField]-15-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_textField]-0-|" options:0 metrics:nil views:views]];

    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
