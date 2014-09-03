//
//  NMRibbonCell.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRibbonCell.h"

@implementation NMRibbonCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *banner = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - 289.5/2, -3, 289.5, 35)];
        banner.image = [UIImage imageNamed:@"HomeRibbon"];
        [self addSubview:banner];
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
