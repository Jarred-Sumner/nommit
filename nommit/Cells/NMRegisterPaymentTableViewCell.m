//
//  NMRegisterPaymentTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRegisterPaymentTableViewCell.h"
#import "PTKView.h"


@interface NMRegisterPaymentTableViewCell() {
    UIButton *hiddenCardButton;
}

@end

@implementation NMRegisterPaymentTableViewCell

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        // Setup checkout
        PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(24, 20, 290, 45)];
        self.paymentView = paymentView;
        [self.contentView addSubview:paymentView];
        
        // Setup editable checkout
        _hiddenCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 22, 238, 38)];
        _hiddenCardLabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
        _hiddenCardLabel.text = [NSString stringWithFormat:@"%@4242", hiddenCardNums];
        _hiddenCardLabel.textColor = UIColorFromRGB(0xcecece);
        _hiddenCardLabel.font = PDefaultBoldFont;
        _hiddenCardLabel.layer.cornerRadius = 10;
        _hiddenCardLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_hiddenCardLabel];
        hiddenCardButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
        hiddenCardButton.backgroundColor = [UIColor clearColor];
        [hiddenCardButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:hiddenCardButton];
        
        // NSString *sTokenId = [[PFUser currentUser] objectForKey:@"sToken"];
        NSString *sTokenId = @"";
        if (sTokenId) {
            //        [Stripe requestTokenWithID:[[PFUser currentUser] objectForKey:@"sToken"] completion:^(STPToken *token, NSError *error) {
            //
            //            if (!error) {
            //                sToken = token;
            //                sCard = [[PFUser currentUser] objectForKey:@"sCard"];
            //                hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, sCard];
            //                hiddenCardLabel.hidden = NO;
            //                hiddenCardButton.hidden = NO;
            //            } else {
            //                sCard = @"4242";
            //                hiddenCardLabel.hidden = YES;
            //                hiddenCardButton.hidden = YES;
            //                self.paymentView.hidden = NO;
            //            }
            //        }];
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
