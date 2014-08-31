//
//  NMOrderFoodView.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodView.h"

const int headerHeight = 146;

@implementation NMOrderFoodView

- (id)initWithFrame:(CGRect)frame initWithFoodItem:(NMFoodItem *)foodItem
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.foodItem = foodItem;
        [self setupHeaderImageView];
        [self setupItemInfoView];
        [self setupCampaignTracking];
        [self setupLocationInfoView];
    }
    return self;
}

- (void)setupHeaderImageView
{
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerHeight)];
    headerImageView.image = self.foodItem.headerImage;
    [self addSubview:headerImageView];
}

- (void)setupItemInfoView
{
    
}

- (void)setupCampaignTracking
{
    
}

- (void)setupLocationInfoView
{
    
}

@end
