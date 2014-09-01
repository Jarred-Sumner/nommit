//
//  NMCampaignInfoView.m
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCampaignInfoView.h"

@implementation NMCampaignInfoView

- (id)initWithFrame:(CGRect)frame withNumberLeft:(NSUInteger)numberLeft withNumberTotal:(NSUInteger)numberTotal
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.layer.borderWidth = 1.0f;
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
