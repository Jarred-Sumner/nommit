//
//  NMOrderFoodView.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodView.h"
#import "NMColors.h"
#import "NMItemHeaderView.h"
#import "NMItemInfoView.h"
#import "NMCampaignInfoView.h"

const int headerHeight = 146;

@interface NMOrderFoodView() {
    NMItemHeaderView *headerImageView;
    NMItemInfoView *itemInfoView;
    NMCampaignInfoView *campaignInfoView;
    UILabel *campaignSold;
    UIView *progressBar;
}

@end

@implementation NMOrderFoodView

- (id)initWithFrame:(CGRect)frame initWithFoodItem:(NMFoodItem *)foodItem
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.foodItem = foodItem;
        [self setupItemInfoView];
        [self setupHeaderImageView];
        [self setupCampaignInfoView];
        [self setupLocationInfoView];
    }
    return self;
}

- (void)setupHeaderImageView
{
    headerImageView = [[NMItemHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerHeight) initWithImage:self.foodItem.headerImage];
    [self addSubview:headerImageView];
}

- (void)setupItemInfoView
{
    itemInfoView = [[NMItemInfoView alloc] initWithFrame:CGRectMake(-1, headerHeight, self.frame.size.width + 2, 99) withItemName:self.foodItem.itemName withItemDescription:self.foodItem.description withPrice:self.foodItem.price];
    
    [self addSubview:itemInfoView];
}

- (void)setupCampaignInfoView
{
    campaignInfoView = [[NMCampaignInfoView alloc] initWithFrame:CGRectMake(-1, itemInfoView.frame.origin.y + itemInfoView.frame.size.height - 1, self.frame.size.width + 2, 120) withNumberLeft:(self.foodItem.itemsTotal - self.foodItem.itemsSold) withNumberTotal:self.foodItem.itemsTotal];
    
    [self addSubview:campaignInfoView];
}

- (void)setupLocationInfoView
{
    
}

@end
