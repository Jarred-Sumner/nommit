//
//  NMLoginViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/4/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLoginViewController.h"
#import "NMFoodsTableViewController.h"
#import "NMActivateAccountTableViewController.h"
#import "NMAppDelegate.h"

@interface NMLoginViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *signView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) FBLoginView *loginView;

@end

@implementation NMLoginViewController

- (void)loadView {
    [super loadView];
    [self setupBG];
    [self setupSign];
    [self setupLogo];
    [self setupMessageLabel];
    [self setupFacebookButton];
    // [self setupCMUBanner];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_signView, _logoView, _loginView   , _messageLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_logoView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_signView]-30-[_logoView]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_signView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_signView]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_messageLabel]-40-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoView]-15-[_messageLabel]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_loginView]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_messageLabel]-25-[_loginView]" options:0 metrics:nil views:views]];
}

- (void)setupBG
{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backgroundImageView.image = [UIImage imageNamed:@"LoginBG"];
    [self.view addSubview:_backgroundImageView];
}

- (void)setupLogo
{
    _logoView = [[UIImageView alloc] init];
    _logoView.image = [UIImage imageNamed:@"LoginLogo"];
    _logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_logoView];
    
}
- (void)setupSign
{
    _signView = [[UIImageView alloc] init];
    _signView.image = [UIImage imageNamed:@"LoginSign"];
    _signView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_signView];
}

- (void)setupFacebookButton
{
    _loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email"]];
    _loginView.contentMode = UIViewContentModeScaleAspectFill;
    _loginView.translatesAutoresizingMaskIntoConstraints = NO;
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}

- (void)setupCMUBanner {
    UIImageView *blankRibbon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CMUBanner"]];
    blankRibbon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blankRibbon];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(blankRibbon, _loginView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[blankRibbon]-15-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[blankRibbon]-50-|" options:0 metrics:nil views:views]];
    
//    UILabel *ribbonLabel = [[UILabel alloc] init];
//    ribbonLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    ribbonLabel.text = @"Only at Carnegie Mellon";
//    ribbonLabel.textColor = [UIColor whiteColor];
//    ribbonLabel.font = [UIFont fontWithName:@"Avenir" size:18.0f];
//    ribbonLabel.textAlignment = NSTextAlignmentCenter;
//    [blankRibbon addSubview:ribbonLabel];
//    
//    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
//    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
    
}

- (void)setupMessageLabel
{
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12.0f];
    _messageLabel.textColor = UIColorFromRGB(0x878787);
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _messageLabel.text = @"To use nommit, please sign in with Facebook. Only available to CMU students.";
    
    [self.view addSubview:_messageLabel];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    __block NMLoginViewController *this = self;
    if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Facebook Login Required" andMessage:@"Nommit requires Facebook to login. Please authenticate with Facebook to continue. If you're not comfortable doing that, please reach out to support"];
        [alert addButtonWithTitle:@"Email Support" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            // Email Subject
            NSString *subject = @"Help with Nommit";
            // Email Content
            
            NSArray *toRecipents = [NSArray arrayWithObject:@"support@getnommit.com"];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = this;
            [mc setSubject:subject];
            [mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            [self.navigationController presentViewController:mc animated:YES completion:NULL];
        }];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Error while logging in" andMessage:@"An error occurred while trying to login. Please try again"];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
    }

}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    [SVProgressHUD showWithStatus:@"Logging in..." maskType:SVProgressHUDMaskTypeBlack];
    [[NMApi instance] POST:@"sessions" parameters:@{ @"access_token" : FBSession.activeSession.accessTokenData.accessToken } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        [[Mixpanel sharedInstance] track:@"Sign In"];
        [NMSession setSessionID:response.HTTPResponse.allHeaderFields[@"X-SESSION-ID"]];
        [NMSession setUserID:[response.result facebookUID]];
        [NMApi resetInstance];
        
        [NMPlace refreshAllWithCompletion:^(id response, NSError *error) {
            
            [SVProgressHUD showSuccessWithStatus:@"Signed in!"];
            if ([NMUser currentUser].state == NMUserStateActivated) {
                NMFoodsTableViewController *foodsViewController = [[NMFoodsTableViewController alloc] init];
                [self.navigationController pushViewController:foodsViewController animated:YES];
                [(NMMenuNavigationController*)self.navigationController setDisabledMenu:NO];
                
            } else if ([NMUser currentUser].state == NMUserStateRegistered) {
                NMActivateAccountTableViewController *activateVC = [[NMActivateAccountTableViewController alloc] init];
                
                [self.navigationController pushViewController:activateVC animated:YES];
            }
        }];
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationItem setHidesBackButton:YES];
    [(NMMenuNavigationController*)self.navigationController setDisabledMenu:YES];
}

-(BOOL)prefersStatusBarHidden { return YES; }


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
