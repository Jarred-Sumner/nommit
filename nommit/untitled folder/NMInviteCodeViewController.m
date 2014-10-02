//
//  NMInviteCodeViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMInviteCodeViewController.h"
#import "NMInviteCodeView.h"
#import "THContactPickerViewController.h"
#import "NMMenuNavigationController.h"

@implementation NMInviteCodeViewController

- (id)init {
    self = [super init];
    if (self) {
        NMInviteCodeView *inviteView = [[NMInviteCodeView alloc] initWithFrame:self.view.frame];
        inviteView.inviteCode.text = [[NMUser currentUser] referralCode];
        [inviteView.inviteButton addTarget:self action:@selector(inviteButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        self.view = inviteView;
        
        [self initNavBar];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Invite Your Friends";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

- (void)inviteButtonTouched {
    THContactPickerViewController *contactPicker = [[THContactPickerViewController alloc] init];
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
    
    self.navigationController.navigationBarHidden = NO;
    
}



@end
