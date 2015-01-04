//
//  NMRegisterPaymentTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMPaymentInfoTableViewCell.h"
#import "PTKView.h"
#import <TTTAttributedLabel.h>
#import <FAKFontAwesome.h>

@interface NMPaymentInfoTableViewCell() {
    UIButton *hiddenCardButton;
}

@end

@implementation NMPaymentInfoTableViewCell

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        // Setup checkout
        PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(24, 30, 290, 45)];
        self.paymentView = paymentView;
        [self.contentView addSubview:paymentView];
        
        TTTAttributedLabel *poweredby = [[TTTAttributedLabel alloc] init];
        poweredby.translatesAutoresizingMaskIntoConstraints = NO;
        poweredby.textAlignment = NSTextAlignmentCenter;
        
        NSDictionary *attrs = @{
                                NSForegroundColorAttributeName: UIColorFromRGB(0x636363)
                                };
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"" attributes:attrs];
        
        FAKFontAwesome *lockIcon = [FAKFontAwesome lockIconWithSize:12];
        [lockIcon addAttributes:attrs];
        [string appendAttributedString:[lockIcon attributedString]];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@" Secured with Stripe" attributes:attrs]];
        
        attrs = @{
                                NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light"  size:11],
                                NSForegroundColorAttributeName: UIColorFromRGB(0x636363)
                                };
        
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n (Twitter & Lyft use them too!)" attributes:attrs]];
        poweredby.attributedText = string;
        poweredby.textColor = UIColorFromRGB(0x636363);
        poweredby.font = [UIFont fontWithName:@"Avenir" size:11];
        poweredby.lineBreakMode = NSLineBreakByWordWrapping;
        poweredby.numberOfLines = 2;
        [self.contentView addSubview:poweredby];
        
        
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[poweredby]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(poweredby)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-83-[poweredby]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(poweredby)]];

        _hiddenCardLabel.hidden = YES;
        hiddenCardButton.hidden = YES;
        self.paymentView.hidden = NO;
    }
    return self;
}

- (void)edit:(id)sender {
    self.paymentView.hidden = NO;
    hiddenCardButton.hidden = YES;
    _hiddenCardLabel.hidden = YES;
}

@end
