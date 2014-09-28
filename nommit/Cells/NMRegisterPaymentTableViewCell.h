//
//  NMRegisterPaymentTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKView.h"
#import "STPToken.h"

static NSString *hiddenCardNums = @"XXXX-XXXX-XXXX-";

@interface NMRegisterPaymentTableViewCell : UITableViewCell

@property(weak, nonatomic) PKView *paymentView;
@property (nonatomic, strong) UILabel *hiddenCardLabel;
@property (nonatomic, strong) NSString *sCard;
@property (nonatomic, strong) STPToken *sToken;

@end
