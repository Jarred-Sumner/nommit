//
//  NMInviteCodeViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMInviteCodeViewController.h"
#import "NMInviteCodeView.h"
#import "NMNavigationController.h"
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
    NMNavigationController *navVC = [[NMNavigationController alloc] initWithRootViewController:contactPicker];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    lbb.imageInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    self.navigationItem.leftBarButtonItem = lbb;
    
    self.navigationController.navigationBarHidden = NO;
    
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

- (void)shareOnFacebook {
    if ([FBDialogs canPresentShareDialog] ) {
        NSString *referralCode = [[NMUser currentUser] referralCode];
        
        NSURL *referralURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.getnommit.com/?i=%@", referralCode]];
        NSURL *pic = [NSURL URLWithString:@"http://s3.amazonaws.com/nommit-production/foods/previews/000/000/006/original/open-uri20141029-16665-2r7dj3?1414624684"];
        
        [FBDialogs presentShareDialogWithLink:referralURL name:@"Nommit - food in under 15 minutes" caption:@"Get food delivered to you in under 15 min. Try it now!" description:nil picture:pic clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            if (!error && ![results[@"completionGesture"] isEqualToString:@"cancel"]) {
                [SVProgressHUD showSuccessWithStatus:@"Shared!"];
            } else {
                [SVProgressHUD showErrorWithStatus:@"Failed!"];
            }
        }];
    } else {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:@"Facebook not installed!"];
    }
}

- (void)shareOnMessenger {
    if ([FBDialogs canPresentMessageDialog]) {
        NSString *referralCode = [[NMUser currentUser] referralCode];
        
        NSURL *referralURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.getnommit.com/?i=%@", referralCode]];
        NSURL *pic = [NSURL URLWithString:@"http://s3.amazonaws.com/nommit-production/foods/previews/000/000/006/original/open-uri20141029-16665-2r7dj3?1414624684"];
        [FBDialogs presentMessageDialogWithLink:referralURL name:@"Nommit - food in under 15 minutes" caption:@"Get food delivered to you in under 15 min. Try it now!" description:nil picture:pic clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            if (!error && ![results[@"completionGesture"] isEqualToString:@"cancel"]) {
                [SVProgressHUD showSuccessWithStatus:@"Shared!"];
            } else {
                [SVProgressHUD showErrorWithStatus:@"Failed!"];
            }
        }];
    } else {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:@"Facebook Messenger not installed!"];
    }
}

- (void)shareOnTwitter {
    NSString *referralCode = [[NMUser currentUser] referralCode];
    NSURL *referralURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.getnommit.com/?i=%@", referralCode]];
    NSString *tweetText = @"Get food delivered to campus in < 15 min with Nommit.";
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:tweetText];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        NSString *encodedText = [tweetText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://post?message=%@", encodedText]]];
    } else {
        NSString *encodedText = [tweetText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedURL = [[NSString stringWithFormat:@"%@", referralURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@&url=%@", encodedText, encodedURL]]];
        
    }
    
}



@end
