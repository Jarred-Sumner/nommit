//
//  NMDeliveryCountdownTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "MZTimerLabel.h"

@interface NMDeliveryCountdownTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *deliveryPlace;
@property (nonatomic, strong) MZTimerLabel *timerLabel;

@end
