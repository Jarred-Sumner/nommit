//
//  NMCollectionHeaderView.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMCollectionHeaderView.h"

@implementation NMCollectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:frame];
        headerView.image = [UIImage imageNamed:@"Image1"];
        [self addSubview:headerView];
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
