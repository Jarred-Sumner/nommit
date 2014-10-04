//
//  NMRegisterPhoneTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMPromoTextField.h"

@protocol NMRegisterPhoneTableViewCellDelegate;

@interface NMActivatePhoneTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NMPromoTextField *textField;
@property (nonatomic, weak) id<NMRegisterPhoneTableViewCellDelegate> delegate;

@end

@protocol NMRegisterPhoneTableViewCellDelegate

@required

- (void)checkPhoneValid;

@end