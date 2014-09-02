//
//  NMSmallFlashSaleCell.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodCell.h"
#import "NMColors.h"

@interface NMFoodCell()
{
    UIImageView *itemImageView;
    UILabel *itemsSoldLabel;
    UILabel *itemNameLabel;
    UILabel *itemPriceLabel;
}

@end

@implementation NMFoodCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    UIImageView *cellBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    cellBackground.image = [UIImage imageNamed:@"FoodItemCell"];
    self.backgroundView = cellBackground;
    
    itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];

    
    [self addSubview:itemsSoldLabel];
    [self addSubview:itemImageView];
    
    [self setupNameLabel];
    [self setupPriceLabel];
    
    return self;
}

- (void)setItemImage:(UIImage *)itemImage
{
    itemImageView.image = itemImage;
}

- (void)setItemName:(NSString *)itemName
{
    itemNameLabel.text = itemName;
}

- (void)setItemPrice:(NSUInteger)itemPrice
{
    itemPriceLabel.text = [NSString stringWithFormat:@"$%d", itemPrice];
}

- (void)setItemsSoldAndTotal:(NSArray *)itemsSoldAndTotal {
    self.itemsSold = itemsSoldAndTotal[0];
    self.totalItems = itemsSoldAndTotal[1];
    [self setupSoldLabel];
    [self setupProgressBar];
}

- (void)setupNameLabel
{
    itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, itemImageView.frame.size.height, self.frame.size.width - 20, 21)];
    itemNameLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    itemNameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    [self addSubview:itemNameLabel];
}

- (void)setupSoldLabel
{
    itemsSoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height, self.frame.size.width, 15)];
    itemsSoldLabel.font = [UIFont fontWithName:@"Avenir-Light" size:10.0f];
    itemsSoldLabel.textColor = UIColorFromRGB(0x717171);
    itemsSoldLabel.text = [NSString stringWithFormat:@"%@/%@ left", self.itemsSold, self.totalItems];
    [self addSubview:itemsSoldLabel];
}

- (void)setupProgressBar
{
    // Create a progress bar view and set its appearance
    self.progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(10, itemImageView.frame.size.height + 38, self.frame.size.width - 20, 6.5f)];
    self.progressBarView.barBorderWidth = 1.0f;
    self.progressBarView.barBorderWidth = 0;
    self.progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    self.progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    self.progressBarView.barInnerPadding = 0;
    self.progressBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Add it to your view
    [self addSubview:self.progressBarView];
}

- (void)setupPriceLabel
{
    itemPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, itemNameLabel.frame.origin.y, 30, itemNameLabel.frame.size.height)];
    itemPriceLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:12.0f];
    itemPriceLabel.textColor = UIColorFromRGB(0x60C4BE);
    
    [self addSubview:itemPriceLabel];
}


@end
