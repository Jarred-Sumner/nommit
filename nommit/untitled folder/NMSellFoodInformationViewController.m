//
//  NMSellFoodInformationViewController.m
//  nommit
//
//  Created by Lucy Guo on 11/5/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMSellFoodInformationViewController.h"
#import "NMSellFoodInformationView.h"
#import "NMMenuNavigationController.h"
#import <MessageUI/MessageUI.h>


@interface NMSellFoodInformationViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation NMSellFoodInformationViewController

- (id)init {
    self = [super init];
    if (self) {
        NMSellFoodInformationView *view = [[NMSellFoodInformationView alloc] initWithFrame:self.view.frame];
        [view.emailButton addTarget:self action:@selector(emailButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        self.view = view;
        [self initNavBar];
    }
    return self;
}

- (void)emailButtonTouched {
    
    if ([MFMailComposeViewController canSendMail]) {
        NSString *subject = @"Selling with Nommit";
        NSString *messageBody = [NSString stringWithFormat:@"Hey Nommit, <br><br> I'd like to sell food on Nommit. My User ID is %@. Here's what I'm thinking: <br><br><br>", NMUser.currentUser.facebookUID];
        NSArray *toRecipents = [NSArray arrayWithObject:@"support@getnommit.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:subject];
        [mc setMessageBody:messageBody isHTML:YES];
        [mc setToRecipients:toRecipents];

        [self presentViewController:mc animated:YES completion:NULL];
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Email Us" andMessage:@"Email support at support@getnommit.com"];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeCancel handler:NULL];
        [alert addButtonWithTitle:@"Copy" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = @"support@getnommit.com";
        }];
    }
}

#pragma mark - MFMailComposeDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - nav bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Sell Food On Nommit";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

@end
