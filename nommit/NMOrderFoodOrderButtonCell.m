//
//  NMOrderFoodOrderButtonCell.m
//  nommit
//
//  Created by Jarred Sumner on 9/1/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMOrderFoodOrderButtonCell.h"

@implementation NMOrderFoodOrderButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage = [UIImage imageNamed:@"OrderButton"];
        [_orderButton setImage:btnImage forState:UIControlStateNormal];
        _orderButton.contentMode = UIViewContentModeScaleToFill;
        _orderButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) + 10);
        
        [self.contentView addSubview:_orderButton];
        
    }
    return self;
}

@end
