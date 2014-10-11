//
//  NMReceiptTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRateView.h"

@class NMRateView;
@protocol NMReceiptTableViewCellDelegate;

@interface NMReceiptTableViewCell : UITableViewCell

@property (nonatomic, strong) NMRateView* rateVw;
@property (nonatomic, weak) id<NMReceiptTableViewCellDelegate> delegate;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;

@end

@protocol NMRateViewControllerDelegate

@required

-(void)updateRating:(float)rating;

@end
