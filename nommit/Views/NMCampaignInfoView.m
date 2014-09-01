//
//  NMCampaignInfoView.m
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCampaignInfoView.h"
#import <TYMProgressBarView.h>

@implementation NMCampaignInfoView

- (id)initWithFrame:(CGRect)frame withNumberLeft:(NSUInteger)numberLeft withNumberTotal:(NSUInteger)numberTotal
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.layer.borderWidth = 1.0f;
        
        [self setupProgressBar:numberLeft withnumberTotal:numberTotal];
    }
    return self;
}

- (void)setupProgressBar:(NSUInteger)numberLeft withnumberTotal:(NSUInteger)numberTotal
{
    // Create a progress bar view and set its appearance
    TYMProgressBarView *progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(15, 30, self.frame.size.width - 30, 15)];
    progressBarView.barBorderWidth = 1.0f;
    progressBarView.barBorderWidth = 0;
    progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    progressBarView.barInnerPadding = 0;
    
    // Add it to your view
    [self addSubview:progressBarView];
    
    // Set the progress
    progressBarView.progress = ([[NSNumber numberWithInt:numberLeft] floatValue]/[[NSNumber numberWithInt:numberTotal] floatValue]);
}


@end
