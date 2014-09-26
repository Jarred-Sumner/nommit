//
//  NMAccountPromoTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMAccountPromoTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *creditLabel;

@end
