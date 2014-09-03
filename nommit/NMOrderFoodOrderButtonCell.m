//
//  NMOrderFoodOrderButtonCell.m
//  nommit
//
//  Created by Jarred Sumner on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
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
        _orderButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 10);
        
        [_orderButton addTarget:_delegate action:@selector(orderFoodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_orderButton];
        
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
