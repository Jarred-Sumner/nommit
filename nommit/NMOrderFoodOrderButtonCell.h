//
//  NMOrderFoodOrderButtonCell.h
//  nommit
//
//  Created by Jarred Sumner on 9/1/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMOrderFoodOrderButtonCell;

@interface NMOrderFoodOrderButtonCell : UITableViewCell

@property (nonatomic, strong) UIButton *orderButton;

@end