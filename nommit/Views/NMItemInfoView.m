//
//  NMItemInfoView.m
//  nommit
//
//  Created by Lucy Guo on 8/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMItemInfoView.h"
#import "NMColors.h"

@interface NMItemInfoView() {
    UILabel *itemName;
    UILabel *itemDescription;
    UILabel *itemPrice;
}

@end
@implementation NMItemInfoView

- (id)initWithFrame:(CGRect)frame withItemName:(NSString *)name withItemDescription:(NSString *)itemDescription withPrice:(NSUInteger)price
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NMColors lightGray];
        self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.layer.borderWidth = 1.0f;
        
        [self setupItemNameLabel:name];
        [self setupItemDescriptionLabel:itemDescription];
        [self setupItemPriceLabel:price];
    }
    return self;
}

#pragma mark - item info view helpers

- (void)setupItemNameLabel:(NSString *)name {
    itemName = [[UILabel alloc] init];
    itemName.text = name;
    itemName.numberOfLines = 1;
    itemName.font = [UIFont fontWithName:@"Avenir" size:22];
    itemName.textColor = UIColorFromRGB(0x3C3C3C);
    CGSize textSize = [itemName.text sizeWithFont:itemName.font];
    itemName.frame = CGRectMake(15, 10, textSize.width, textSize.height);
    [itemName sizeToFit];
    [self addSubview:itemName];
}

- (void)setupItemDescriptionLabel:(NSString *)description {
    itemDescription = [[UILabel alloc] init];
    itemDescription.text = description;
    itemDescription.numberOfLines = 0;
    itemDescription.font = [UIFont fontWithName:@"Avenir" size:11];
    itemDescription.textColor = UIColorFromRGB(0x5D5D5D);
    itemDescription.lineBreakMode = NSLineBreakByWordWrapping;
//    [itemDescription sizeToFit];
    CGSize textSize = [itemDescription.text sizeWithFont:itemDescription.font forWidth:self.frame.size.width - 20 lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize textSize2 = [itemDescription.text boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingUsesFontLeading attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    
    itemDescription.frame = CGRectMake(15, 48, textSize.width, textSize.height);
    
    [itemDescription sizeToFit];
    
    [self addSubview:itemDescription];
}

- (void)setupItemPriceLabel:(NSUInteger)price {
    itemPrice = [[UILabel alloc] init];
    itemPrice.text = [NSString stringWithFormat:@"$%d", price];
    itemPrice.numberOfLines = 0;
    itemPrice.font = [UIFont fontWithName:@"Avenir" size:23];
    itemPrice.textColor = UIColorFromRGB(0x60C4BE);
    
    CGSize textSize = [itemPrice.text sizeWithFont:itemPrice.font];
    itemPrice.frame = CGRectMake(self.frame.size.width - textSize.width - 20, 10, textSize.width, textSize.height);
    [itemPrice sizeToFit];
    [self addSubview:itemPrice];
}

@end
