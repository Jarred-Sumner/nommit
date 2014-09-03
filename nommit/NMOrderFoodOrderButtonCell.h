//
//  NMOrderFoodOrderButtonCell.h
//  nommit
//
//  Created by Jarred Sumner on 9/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMOrderFoodOrderButtonCell;

@interface NMOrderFoodOrderButtonCell : UITableViewCell

@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, weak) id<NMOrderFoodOrderButtonCell> delegate;

@end

@protocol NMOrderFoodOrderButtonCell

@required
-(void)orderFoodButtonPressed:(id)sender;

@end