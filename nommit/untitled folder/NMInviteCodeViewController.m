//
//  NMInviteCodeViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMInviteCodeViewController.h"
#import "NMInviteCodeView.h"
#import "NMMenuNavigationController.h"
#import "THContact.h"

#import <Social/Social.h>

@implementation NMInviteCodeViewController

- (id)init {
    self = [super init];
    if (self) {
        NMInviteCodeView *inviteView = [[NMInviteCodeView alloc] initWithFrame:self.view.frame];
        [inviteView.inviteButton addTarget:self action:@selector(inviteButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [inviteView.facebookButton addTarget:self action:@selector(shareOnFacebook) forControlEvents:UIControlEventTouchUpInside];
        [inviteView.messengerButton addTarget:self action:@selector(shareOnMessenger) forControlEvents:UIControlEventTouchUpInside];
        [inviteView.twitterButton addTarget:self action:@selector(shareOnTwitter) forControlEvents:UIControlEventTouchUpInside];
        self.view = inviteView;
        
        [self initNavBar];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Invite Your Friends";
}

- (void)inviteButtonTouched {
    THContactPickerViewController *contactPicker = [[THContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:contactPicker];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    UIBarButtonItem *rightBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    rightBB.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.rightBarButtonItem = rightBB;
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)share {
    NSString *text = @"Get food delivered in under 15 minutes to campus with Nommit!";
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[text, [NSURL URLWithString:@"http://www.getnommit.com"]] applicationActivities:nil];
    activity.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeSaveToCameraRoll];
    [self.navigationController presentViewController:activity animated:YES completion:NULL];
}

#pragma mark - THContactPickerViewControllerDelegate

- (void)didSelectContacts:(NSArray*)contacts {
    [SVProgressHUD showWithStatus:@"Sending..." maskType:SVProgressHUDMaskTypeBlack];
    NSMutableArray *contactArray = [[NSMutableArray alloc] init];
    for (THContact *contact in contacts) {
        if (!contact.phone.length) continue;
        
        [contactArray addObject:@{ @"name" : contact.fullName, @"phone" : contact.phone }];
    }
    [[NMApi instance] POST:@"invites" parameters:@{ @"contacts" : contactArray } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"Sent!"];
    }];
    
}




@end
