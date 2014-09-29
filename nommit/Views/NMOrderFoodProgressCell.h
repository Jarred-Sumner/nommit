//
//  NMCampaignInfoView.h
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYMProgressBarView.h>
#import "RateView.h"

@interface NMOrderFoodProgressCell : UITableViewCell

@property (nonatomic, strong) UILabel *progressLabel;
@property TYMProgressBarView *progressBarView;
@property (nonatomic, strong) RateView *rateVw;


@end

