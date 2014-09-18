//
//  NMLoginViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/4/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLoginViewController.h"
#import "NMFoodsViewController.h"
#import "NMAppDelegate.h"

@interface NMLoginViewController () {
    UIImageView *signView;
    UIImageView *logoView;
    UILabel *message;
    UIButton *facebookButton;
}

@end

@implementation NMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupBG];
        [self setupSign];
        [self setupLogo];
        [self setupMessage];
        [self setupFacebookButton];
    }
    return self;
}

- (void)setupBG
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"LoginBG"];
    [self.view insertSubview:imageView atIndex:0];
}

- (void)setupLogo
{
    logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"LoginLogo"];
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:logoView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(signView, logoView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[logoView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signView]-20-[logoView]" options:0 metrics:nil views:views]];
}

- (void)setupSign
{
    signView = [[UIImageView alloc] init];
    signView.image = [UIImage imageNamed:@"LoginSign"];
    signView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:signView];
        
    NSDictionary *views = NSDictionaryOfVariableBindings(signView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[signView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[signView]" options:0 metrics:nil views:views]];
}

- (void)setupFacebookButton
{
    facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton setImage:[UIImage imageNamed:@"LoginFacebookButton"] forState:UIControlStateNormal];
    facebookButton.contentMode = UIViewContentModeScaleAspectFill;
    [facebookButton addTarget:self action:@selector(loginFacebookTouched:) forControlEvents:UIControlEventTouchUpInside];
    facebookButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:facebookButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(facebookButton, message);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[facebookButton]-30-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[message]-25-[facebookButton]" options:0 metrics:nil views:views]];
    
}

- (void)setupMessage
{
    message = [[UILabel alloc] init];
    message.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12.0f];
    message.textColor = UIColorFromRGB(0x878787);
    message.textAlignment = NSTextAlignmentCenter;
    message.lineBreakMode = NSLineBreakByWordWrapping;
    message.numberOfLines = 0;
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.text = @"To use nommit, please sign in with Facebook.";
    
    [self.view addSubview:message];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(logoView, message);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[message]-40-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logoView]-15-[message]" options:0 metrics:nil views:views]];
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
    [[NMApi instance] POST:@"sessions" parameters:@{ @"access_token" : session.accessTokenData.accessToken } completion:^(OVCResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            [NMSession setSessionID:response.HTTPResponse.allHeaderFields[@"X-SESSION-ID"]];
            [NMApi instance].session.configuration.HTTPAdditionalHeaders = @{ @"X-SESSION-ID" : [NMSession sessionID] };
            
            [NMSession setUserID:session.accessTokenData.userID];
            NMFoodsViewController *foodsViewController = [[NMFoodsViewController alloc] init];
            [self.navigationController pushViewController:foodsViewController animated:YES];
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden { return YES; }


@end
