//
//  NMSmallFlashSaleCell.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYMProgressBarView.h>

@interface NMFoodCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) TYMProgressBarView *progressBarView;
@property (nonatomic, strong) NSArray *itemsSoldAndTotal;
@property (strong, nonatomic) NSNumber *itemsSold;
@property (strong, nonatomic) NSNumber *totalItems;

@property (nonatomic) NSUInteger itemPrice;

@end
