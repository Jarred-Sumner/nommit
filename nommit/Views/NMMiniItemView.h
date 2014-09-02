//
//  NMMiniItemView.h
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMMiniItemView : UIView

@property (strong, nonatomic) UIImage *itemImage;
@property (strong, nonatomic) UILabel *itemName;
@property (nonatomic) NSUInteger *itemsSold;
@property (nonatomic) NSUInteger *totalItems;

@end
