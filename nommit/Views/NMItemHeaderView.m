//
//  NMItemHeaderView.m
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMItemHeaderView.h"

@implementation NMItemHeaderView

- (id)initWithFrame:(CGRect)frame initWithImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = image;
    }
    return self;
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
