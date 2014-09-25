//
//  NMOrderLocationView.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger NMOrderLocationViewHeight = 54;

@interface NMOrderLocationView : UIView

@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nextLabel;

@end
