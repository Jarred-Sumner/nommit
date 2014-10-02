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
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 86.5*1.3, 21*1.3)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(15, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}



@end
