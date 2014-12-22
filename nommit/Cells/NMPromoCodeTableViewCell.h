//
//  NMPromoCodeTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/23/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMPromoCodeTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end
