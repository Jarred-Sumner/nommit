//
//  NMAccountPromoTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMPromoTextField.h"

@interface NMAccountPromoTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NMPromoTextField *textField;

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *creditLabel;

@end
