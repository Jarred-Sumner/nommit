//
//  NMRegisterPaymentTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMActivatePaymentTableViewCell.h"
#import "PTKView.h"
#import <TTTAttributedLabel.h>

@interface NMActivatePaymentTableViewCell() {
    UIButton *hiddenCardButton;
}

@end

@implementation NMActivatePaymentTableViewCell

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        // Setup checkout
        PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(24, 10, 290, 45)];
        self.paymentView = paymentView;
        [self.contentView addSubview:paymentView];
        
        TTTAttributedLabel *poweredby = [[TTTAttributedLabel alloc] init];
        poweredby.translatesAutoresizingMaskIntoConstraints = NO;
        
        poweredby.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"Secured with Stripe"]];
        
        NSDictionary *attrs = @{
            NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light"  size:11],
//            NSForegroundColorAttributeName:  };
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n (Lyft & Twitter use them too!)" attributes:attrs]];
        poweredby.attributedText = string;
        poweredby.textColor = UIColorFromRGB(0x5F5F5F);
        poweredby.font = [UIFont fontWithName:@"Avenir" size:11];
        poweredby.lineBreakMode = NSLineBreakByWordWrapping;
        poweredby.numberOfLines = 2;
        [self.contentView addSubview:poweredby];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[poweredby]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(poweredby)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[paymentView]-8-[poweredby]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(poweredby, paymentView)]];
        NSString *sTokenId = @"";
        if (sTokenId) {
            _sCard = @"4242";
            _hiddenCardLabel.hidden = YES;
            hiddenCardButton.hidden = YES;
            self.paymentView.hidden = NO;
            
            
        } else {
            _sCard = @"4242";
            _hiddenCardLabel.hidden = YES;
            hiddenCardButton.hidden = YES;
            self.paymentView.hidden = NO;
        }

    }
    return self;
}

- (void)edit:(id)sender {
    NSLog(@"editing now");
    self.paymentView.hidden = NO;
    hiddenCardButton.hidden = YES;
    _hiddenCardLabel.hidden = YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
