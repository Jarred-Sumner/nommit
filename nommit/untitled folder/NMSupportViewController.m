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

@implementation NMSupportViewController

- (id)init {
    self = [super init];
    if (self) {
        NMSupportView *supportView = [[NMSupportView alloc] initWithFrame:self.view.frame];
        [supportView.callButton addTarget:self action:@selector(callButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [supportView.emailButton addTarget:self action:@selector(emailButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        self.view = supportView;
        
        [self initNavBar];
    }
    return self;
}

- (void)callButtonTouched {
    
}

- (void)emailButtonTouched {
    
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
