//
//  NMLoginViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/4/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMLoginViewController.h"
#import "NMFoodsTableViewController.h"
#import "NMSchoolsViewController.h"
#import "NMActivateAccountTableViewController.h"
#import "NMAppDelegate.h"
#import <CPKenBurnsImage.h>
#import <CPKenBurnsSlideshowView.h>

const int numSlideshowPictures = 4;

@interface NMLoginViewController ()<CPKenburnsSlideshowViewDeleagte>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *loginContainer;
@property (nonatomic, strong) UIImageView *signView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) FBLoginView *loginView;

@property (strong, nonatomic) CPKenburnsSlideshowView *kenburnsSlideshowView;
@property (strong, nonatomic) UISlider *slider;

@end

@implementation NMLoginViewController

- (void)loadView {
    [super loadView];
    [self setupSlideShow];
    [self setupLogo];
    [self setupContainer];
    [self setupDescriptionLabel];
    [self setupMessageLabel];
    [self setupFacebookButton];
    // [self setupCMUBanner];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_logoView, _loginView   , _messageLabel, _loginContainer, _descriptionLabel);
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_loginContainer]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-186-[_loginContainer]" options:0 metrics:nil views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_logoView]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-87-[_logoView]" options:0 metrics:nil views:views]];
    
    [_loginContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_descriptionLabel]|" options:0 metrics:nil views:views]];
    [_loginContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_descriptionLabel]" options:0 metrics:nil views:views]];
    
    [_loginContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_messageLabel]-40-|" options:0 metrics:nil views:views]];
    [_loginContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_messageLabel]-10-|" options:0 metrics:nil views:views]];
    
    [_loginContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_loginView]-30-|" options:0 metrics:nil views:views]];
    [_loginContainer  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_descriptionLabel]-12-[_loginView]" options:0 metrics:nil views:views]];


}

- (void)setupContainer {
    _loginContainer = [[UIImageView alloc] init];
    _loginContainer.image = [UIImage imageNamed:@"LoginContainer"];
    _loginContainer.translatesAutoresizingMaskIntoConstraints = NO;
    _loginContainer.userInteractionEnabled = YES;
    [self.view addSubview:_loginContainer];
}


- (void)setupLogo
{
    _logoView = [[UIImageView alloc] init];
    _logoView.image = [UIImage imageNamed:@"LoginLogo"];
    _logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_logoView];
    
}

- (void)setupFacebookButton
{
    _loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email"]];
    _loginView.contentMode = UIViewContentModeScaleAspectFill;
    _loginView.translatesAutoresizingMaskIntoConstraints = NO;
    _loginView.delegate = self;
    [_loginContainer addSubview:_loginView];
}

- (void)setupCMUBanner {
    UIImageView *blankRibbon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CMUBanner"]];
    blankRibbon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blankRibbon];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(blankRibbon, _loginView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[blankRibbon]-15-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[blankRibbon]-50-|" options:0 metrics:nil views:views]];
    
}

- (void)setupDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:21.0f];
    _descriptionLabel.textColor = [UIColor whiteColor];
    _descriptionLabel.alpha = .86f;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.text = @"Food delivered in under \n 15 minutes.";
    
    [_loginContainer addSubview:_descriptionLabel];
    
}

- (void)setupMessageLabel
{
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12.0f];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.alpha = .86f;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _messageLabel.text = @"Available at select universities";
    
    [_loginContainer addSubview:_messageLabel];
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
        
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
           [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:localContext error:nil];
        }];
        
        
        [NMSession setUserID:[response.result facebookUID]];
        [NMSession setSessionID:response.HTTPResponse.allHeaderFields[@"X-SESSION-ID"]];
        [[Mixpanel sharedInstance] track:@"Sign In"];
        [NMApi resetInstance];
        
        [NMPlace refreshAllWithCompletion:^(id response, NSError *error) {
            
            [SVProgressHUD showSuccessWithStatus:@"Signed in!"];
            if ([NMUser currentUser].state == NMUserStateActivated) {
                NMFoodsTableViewController *foodsViewController = [[NMFoodsTableViewController alloc] init];
                [self.navigationController pushViewController:foodsViewController animated:YES];
                [(NMNavigationController*)self.navigationController setDisabledMenu:NO];
                
            } else if ([NMUser currentUser].state == NMUserStateRegistered) {
                
                [[Mixpanel sharedInstance] track:@"Start Activation Flow"];
                
                __block NMNavigationController *navVC = self.navigationController;
                [(NMNavigationController*)navVC setDisabledMenu:YES];

                NMSchoolsViewController *vc = [[NMSchoolsViewController alloc] initWithCompletionBlock:^{
                    NMActivateAccountTableViewController *activateVC = [[NMActivateAccountTableViewController alloc] init];
                    [navVC pushViewController:activateVC animated:YES];
                }];
                vc.navigationItem.hidesBackButton = YES;
                [navVC pushViewController:vc animated:YES];
                
                
            }
        }];
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationItem setHidesBackButton:YES];
    [(NMNavigationController*)self.navigationController setDisabledMenu:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupSlideShow {
    self.kenburnsSlideshowView = [[CPKenburnsSlideshowView alloc] initWithFrame:self.view.bounds];
    _slider = [[UISlider alloc] initWithFrame:self.view.frame];
    self.kenburnsSlideshowView.delegate = self;
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < numSlideshowPictures + 1; i++) {
        CPKenburnsImage *image = [CPKenburnsImage new];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"LoginBG%d",i]];
        [images addObject:image];
    }
    
    self.kenburnsSlideshowView.images = images;
    self.kenburnsSlideshowView.longTapGestureEnable = NO;
    
    [self.view addSubview:_kenburnsSlideshowView];
}

#pragma mark - KenBurns Slideshow Delegate Methods

- (void)slideshowView:(CPKenburnsSlideshowView *)slideshowView willShowKenburnsView:(CPKenburnsView *)kenBurnsView
{
    
    kenBurnsView.animationDuration = 8.0f;
    kenBurnsView.startZoomRate = .7;
    kenBurnsView.endZoomRate = 1;
    kenBurnsView.zoomRatio = .3;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(BOOL)prefersStatusBarHidden { return YES; }


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
