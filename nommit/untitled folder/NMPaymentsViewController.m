//
//  NMPaymentsViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/8/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPaymentsViewController.h"
#import "PKView.h"
#import "NMColors.h"
#import "NMFoodsViewController.h"
#import "Stripe.h"
#import "MBProgressHUD.h"
#import "NMMenuNavigationController.h"
#import "Constants.h"

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]
static NSString *hiddenCardNums = @"XXXX-XXXX-XXXX-";

@interface NMPaymentsViewController ()<PKViewDelegate> {
    UILabel *hiddenCardLabel;
    UIButton *hiddenCardButton;
    STPToken *sToken;
    NSString *sCard;
}
@property(weak, nonatomic) PKView *paymentView;
@end

@implementation NMPaymentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Payment Information";
    self.view.backgroundColor = [NMColors lightGray];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // setup cancel button
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Setup checkout
    PKView *paymentView = [[PKView alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    paymentView.delegate = self;
    self.paymentView = paymentView;
    [self.view addSubview:paymentView];
    
    // Setup editable checkout
    hiddenCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 22, 238, 38)];
    hiddenCardLabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
    hiddenCardLabel.text = [NSString stringWithFormat:@"%@4242", hiddenCardNums];
    hiddenCardLabel.textColor = UIColorFromRGB(0xcecece);
    hiddenCardLabel.font = PDefaultBoldFont;
    hiddenCardLabel.layer.cornerRadius = 10;
    hiddenCardLabel.layer.masksToBounds = YES;
    
    [self.view addSubview:hiddenCardLabel];
    hiddenCardButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    hiddenCardButton.backgroundColor = [UIColor clearColor];
    [hiddenCardButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hiddenCardButton];
    
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
        sCard = @"4242";
        hiddenCardLabel.hidden = YES;
        hiddenCardButton.hidden = YES;
        self.paymentView.hidden = NO;

        
    } else {
        sCard = @"4242";
        hiddenCardLabel.hidden = YES;
        hiddenCardButton.hidden = YES;
        self.paymentView.hidden = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [NMColors mainColor]};
}

- (void)paymentView:(PKView *)paymentView
           withCard:(PKCard *)card
            isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (void)cancel:(id)sender {
    NMFoodsViewController *mainVC = [[NMFoodsViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)edit:(id)sender {
    NSLog(@"editing now");
    self.paymentView.hidden = NO;
    hiddenCardButton.hidden = YES;
    hiddenCardLabel.hidden = YES;
}

- (IBAction)save:(id)sender {
    if (self.paymentView.hidden == YES) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (![self.paymentView isValid]) {
        return;
    }
    // TODO : in stripe.m , define defaultKey  = @"pk_test_CbJfLmFFADyn0piYUJIgr7MQ"
    if (![Stripe defaultPublishableKey]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Publishable Key"
                                                          message:@"Please specify a Stripe Publishable Key in Constants.m"
                                                         delegate:nil
                                                cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [self hasError:error];
        } else {
            sCard = [card.number substringFromIndex:[card.number length] - 4] ;
            // [[PFUser currentUser] setObject:sCard forKey:@"sCard"];
            sToken = token;
//            [[PFUser currentUser] setObject:[token tokenId] forKey:@"sToken"];
//            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (!succeeded) {
//                    NSLog(@"Error setting Stripe Token: %@", error);
//                }
//            }];
//            NSDictionary *chargeParams = @{
//                                           @"card": [token tokenId],
//                                           @"objectId": [[PFUser currentUser] objectId]
//                                           };
//            [PFCloud callFunctionInBackground:@"register" withParameters:chargeParams block:^(id object, NSError *error) {
//                NSLog(@"%@", error);
//                [[PFUser currentUser] setObject:(NSString *)object forKey:@"sCustomerId"];
//                [[PFUser currentUser] saveInBackground];
//            }];
            hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, sCard];
            hiddenCardLabel.hidden = NO;
            hiddenCardButton.hidden = NO;
            [self hasToken:token];
        }
    }];
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    NSDictionary *chargeParams = @{
    //                                   @"token": token.tokenId,
    //                                   @"currency": @"usd",
    //                                   @"amount": @"1000", // this is in cents (i.e. $10)
    //                                   };
    
//    if (![Parse getApplicationId] || ![Parse getClientKey]) {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Todo: Submit this token to your backend"
//                                                          message:[NSString stringWithFormat:@"Good news! Stripe turned your credit card into a token: %@ \nYou can follow the instructions in the README to set up Parse as an example backend, or use this token to manually create charges at dashboard.stripe.com .", token.tokenId]
//                                                         delegate:nil
//                                                cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
//                                                otherButtonTitles:nil];
    
//        [message show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NMFoodsViewController *mainVC = [[NMFoodsViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
        return;
    
    }
    
    // This passes the token off to our payment backend, which will then actually complete charging the card using your account's
    //    [PFCloud callFunctionInBackground:@"charge" withParameters:chargeParams block:^(id object, NSError *error) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        if (error) {
    //            [self hasError:error];
    //            return;
    //        }
    //        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    //            [[[UIAlertView alloc] initWithTitle:@"Payment Succeeded" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    //        }];
    //    }];

@end
