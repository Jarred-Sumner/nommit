//
//  NMVerifyPhoneNumerTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/27/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMPromoTextField.h"

@protocol NMConfirmPhoneTableViewCellDelegate

@required

- (void)confirmCodeDidChange:(NSString*)confirmCode;

@end

@interface NMConfirmPhoneTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) NMPromoTextField *textField;
@property (nonatomic, weak) id<NMConfirmPhoneTableViewCellDelegate> delegate;


@end