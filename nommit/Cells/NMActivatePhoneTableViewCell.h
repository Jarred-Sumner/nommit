//
//  NMRegisterPhoneTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMPromoTextField.h"

@interface NMActivatePhoneTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NMPromoTextField *textField;

@end