//
//  NMCampaignInfoView.h
//  nommit
//
//  Created by Lucy Guo on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYMProgressBarView.h>
#import "CHDigitInput.h"

@protocol NMOrderFoodProgressCell;

@interface NMOrderFoodProgressCell : UITableViewCell

@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *quantityLabel;
@property TYMProgressBarView *progressBarView;
@property CHDigitInput *quantityInput;

@property (nonatomic, weak) id<NMOrderFoodProgressCell> delegate;


@end

@protocol NMOrderFoodProgressCell

@required
-(void)quantityDidChange;

@end
