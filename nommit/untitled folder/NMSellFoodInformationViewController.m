//
//  NMSellFoodInformationViewController.m
//  nommit
//
//  Created by Lucy Guo on 11/5/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSellFoodInformationViewController.h"
#import "NMSellFoodInformationView.h"
#import "NMMenuNavigationController.h"
#import <MessageUI/MessageUI.h>


@interface NMSellFoodInformationViewController ()

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
    // Email Subject
    NSString *subject = @"Selling with Nommit";
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Hey Nommit, <br><br> I'd like to sell food on Nommit. My User ID is %@. Here's what I'm thinking: <br><br><br>", NMUser.currentUser.facebookUID];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.title = @"Sell Food On Nommit";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
