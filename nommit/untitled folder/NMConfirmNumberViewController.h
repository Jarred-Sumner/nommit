//
//  NMVerifyPhoneNumberViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"NMPromoTextField.h"
#import "NMConfirmPhoneTableViewCell.h"

@interface NMConfirmNumberViewController : UITableViewController<UITextFieldDelegate, NMConfirmPhoneTableViewCellDelegate>

@end
