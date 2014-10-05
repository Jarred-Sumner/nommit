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
@property (nonatomic, strong) UIButton *facebookButton;

@end

@implementation NMLoginViewController

- (void)loadView {
    [super loadView];
    [self setupBG];
    [self setupSign];
    [self setupLogo];
    [self setupMessageLabel];
    [self setupFacebookButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_signView, _logoView, _facebookButton, _messageLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_logoView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_signView]-20-[_logoView]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_signView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_signView]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_messageLabel]-40-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoView]-15-[_messageLabel]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_facebookButton]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_messageLabel]-25-[_facebookButton]" options:0 metrics:nil views:views]];
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
    _facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_facebookButton setImage:[UIImage imageNamed:@"LoginFacebookButton"] forState:UIControlStateNormal];
    _facebookButton.contentMode = UIViewContentModeScaleAspectFill;
    _facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_facebookButton];

    [_facebookButton addTarget:self action:@selector(loginFacebookTouched:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)loginFacebookTouched:(id)sender
{
    if (FBSession.activeSession.isOpen) {
        [self performLoginWithFBSession:FBSession.activeSession];
    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email"]
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          if (error) {
                                              NSLog(@"Error: %@", error);
                                          } else [self performLoginWithFBSession:session];
          }];
    }
}

- (void)performLoginWithFBSession:(FBSession*)session {
    [SVProgressHUD showWithStatus:@"Logging in..." maskType:SVProgressHUDMaskTypeBlack];
    [[NMApi instance] POST:@"sessions" parameters:@{ @"access_token" : session.accessTokenData.accessToken } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        [NMSession setSessionID:response.HTTPResponse.allHeaderFields[@"X-SESSION-ID"]];
        [NMApi instance].session.configuration.HTTPAdditionalHeaders = @{ @"X-SESSION-ID" : [NMSession sessionID] };
        [NMSession setUserID:[response.result facebookUID]];
        
        [[NMApi instance] GET:@"places" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"Logged in!"];
            
            if ([NMUser currentUser].state == NMUserStateActivated) {
                NMFoodsTableViewController *foodsViewController = [[NMFoodsTableViewController alloc] init];
                [self.navigationController pushViewController:foodsViewController animated:YES];
                [(NMMenuNavigationController*)self.navigationController setDisabledMenu:NO];
                
            } else if ([NMUser currentUser].state == NMUserStateRegistered) {
                NMActivateAccountTableViewController *activateVC = [[NMActivateAccountTableViewController alloc] init];
                
                [self.navigationController pushViewController:activateVC animated:YES];
            }
            [[NMApi instance] GET:@"shifts" parameters:nil completion:NULL];
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


@end
