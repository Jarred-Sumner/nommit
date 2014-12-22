//
//  NMMiniItemView.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMMiniItemView.h"

@interface NMMiniItemView() {
    UIImageView *itemImageView;
    UILabel *itemsSoldLabel;
}

@end

@implementation NMMiniItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    itemsSoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, itemImageView.frame.size.height + 15, frame.size.width, 50)];
    
    [self addSubview:itemsSoldLabel];
    [self addSubview:itemImageView];
    return self;
}

- (void)setItemImage:(UIImage *)itemImage
{
    itemImageView.image = itemImage;
}


@end
