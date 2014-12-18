//
//  NMRegisterPaymentTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKView.h"
#import "STPToken.h"

static NSString *hiddenCardNums = @"XXXX-XXXX-XXXX-";

@interface NMPaymentInfoTableViewCell : UITableViewCell

@property(weak, nonatomic) PTKView *paymentView;
@property (nonatomic, strong) UILabel *hiddenCardLabel;
@property (nonatomic, strong) NSString *sCard;
@property (nonatomic, strong) STPToken *sToken;

@end
