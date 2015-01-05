//
//  NMFooterRequestView.h
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFooterRequestView : UIView

@property (nonatomic, strong) UILabel *footerText;

- (id)initWithText:(NSString *)regularString withUnderlinedString:(NSString *)underlinedString withFrame:(CGRect)frame;

@end
