//
//  NMOrderFoodBasicInfoTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHDigitInput.h"

@protocol NMOrderFoodBasicInfoTableViewCellDelegate;

@interface NMOrderFoodBasicInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIImageView *avatar;
@property CHDigitInput *quantityInput;

@property (nonatomic, weak) id<NMOrderFoodBasicInfoTableViewCellDelegate> delegate;

@end

@protocol NMOrderFoodBasicInfoTableViewCellDelegate

@required
-(void)quantityDidChange;

@end
