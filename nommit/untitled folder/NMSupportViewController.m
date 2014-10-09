//
//  NMSupportViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSupportViewController.h"
#import "NMSupportView.h"
#import "NMMenuNavigationController.h"
#import <MessageUI/MessageUI.h>

@interface NMSupportViewController()<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation NMSupportViewController

- (id)init {
    self = [super init];
    if (self) {
        NMSupportView *supportView = [[NMSupportView alloc] initWithFrame:self.view.frame];
        [supportView.callButton addTarget:self action:@selector(callButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [supportView.emailButton addTarget:self action:@selector(emailButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [supportView.textButton addTarget:self action:@selector(textButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        self.view = supportView;
        
        [self initNavBar];
    }
    return self;
}

- (void)textButtonTouched {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:+11111"]]) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.subject = @"Nommit Support";
        controller.messageComposeDelegate = self;
        controller.recipients = @[@"+14152739617"];
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Cannot Text" andMessage:@"This device doesn't support texting. Sorry about that."];
        [alert addButtonWithTitle:@"It's Okay" type:SIAlertViewButtonTypeDefault handler:NULL];
        [alert addButtonWithTitle:@"I'll Email" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [self emailButtonTouched];
        }];
        [alert show];
    }
    
}

- (void)callButtonTouched {
    NSString *phNo = @"+14152739617";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Can't Place Calls" andMessage:@"This device can't place phone calls. Sorry about that."];
        [alert addButtonWithTitle:@"It's Okay" type:SIAlertViewButtonTypeDefault handler:NULL];
        [alert addButtonWithTitle:@"I'll Email" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [self emailButtonTouched];
        }];
        [alert show];
    }
    
}

- (void)emailButtonTouched {
    // Email Subject
    NSString *subject = @"Help with Nommit";
    // Email Content
    NSString *messageBody = @"Hey Nommit, <br><br> I'm having some trouble. Here's an explanation of the problem, and what if any steps I can think of to reproduce it: <br><br><br>";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@getnommit.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:subject];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];

}

#pragma mark - email delegate methods

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - text delegate methods

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Mail failed");
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Support";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

@end
