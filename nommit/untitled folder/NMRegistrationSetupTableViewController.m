//
//  NMRegistrationSetupTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRegistrationSetupTableViewController.h"
#import "NMAccountInformationTableViewCell.h"
#import "NMTableSeparatorView.h"
#import "NMRegisterPhoneTableViewCell.h"
#import "NMRegisterPaymentTableViewCell.h"
#import "PTKView.h"
#import "NMColors.h"
#import "Stripe.h"
#import "SVProgressHUD.h"
#import "NMMenuNavigationController.h"
#import "NMFoodsTableViewController.h"
#import "Constants.h"
#import "NMVerifyPhoneNumberViewController.h"


@interface NMRegistrationSetupTableViewController ()<PTKViewDelegate>

@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMRegisterPaymentTableViewCell *paymentCell;
@property (nonatomic, strong) NMRegisterPhoneTableViewCell *phoneCell;

@end

@implementation NMRegistrationSetupTableViewController

const NSInteger NMAccountInfoSection = 0;
const NSInteger NMRegisterPaymentSection = 1;
const NSInteger NMRegisterPhoneSection = 2;

static NSString *NMAccountInfoTableViewCellKey = @"NMAcountInfoTableViewCell";
static NSString *NMRegisterPaymentTableViewCellKey = @"NMRegisterPaymentTableViewCell";
static NSString *NMRegisterPhoneTableViewCellKey = @"NMRegisterPhoneTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initNavBar];
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInfoTableViewCellKey];
        [self.tableView registerClass:[NMRegisterPhoneTableViewCell class] forCellReuseIdentifier:NMRegisterPhoneTableViewCellKey];
        [self.tableView registerClass:[NMRegisterPaymentTableViewCell class] forCellReuseIdentifier:NMRegisterPaymentTableViewCellKey];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // setup cancel button
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInfoSection) {
        return 76;
    }
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];
    if (section == NMAccountInfoSection) {
        separatorView.sectionLabel.text = @"ACCOUNT INFORMATION";
    } else if (section == NMRegisterPhoneSection) {
        separatorView.sectionLabel.text = @"ENTER PHONE NUMBER";
    } else if (section == NMRegisterPaymentSection) {
        separatorView.sectionLabel.text = @"ENTER PAYMENT INFORMATION";
    }
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountInfoTableViewCellKey];
        
        _infoCell.nameLabel.text = @"Lucy Guo";
        _infoCell.emailLabel.text = @"lucyguo@cmu.edu";
        return _infoCell;
    } else if (indexPath.section == NMRegisterPhoneSection) {
        _phoneCell = [self.tableView dequeueReusableCellWithIdentifier:NMRegisterPhoneTableViewCellKey];
        _phoneCell.delegate = self;
        return _phoneCell;
    } else if (indexPath.section == NMRegisterPaymentSection) {
        _paymentCell = [self.tableView dequeueReusableCellWithIdentifier:NMRegisterPaymentTableViewCellKey];
        _paymentCell.paymentView.delegate = self;
        return _paymentCell;
    }
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - nav bar

- (void)initNavBar
{
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - payments information

- (void)paymentView:(PTKView *)paymentView
           withCard:(PTKCard *)card
            isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    if ([_phoneCell.textField.text length] > 0) {
        self.navigationItem.rightBarButtonItem.enabled = valid;
    }
}

- (void)cancel:(id)sender {
    NMFoodsTableViewController *mainVC = [[NMFoodsTableViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (IBAction)save:(id)sender {
    NMVerifyPhoneNumberViewController *verifyPhoneNumberVC = [[NMVerifyPhoneNumberViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:verifyPhoneNumberVC animated:YES];
    // SAVING ACTIONS :
    if (_paymentCell.paymentView.hidden == YES) {
        [SVProgressHUD showWithStatus:@"Verifying..."];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (![_paymentCell.paymentView isValid]) {
        [SVProgressHUD showErrorWithStatus:@"Invalid Credit Card! Please re-enter it and try again"];
        return;
    }
    // TODO : in stripe.m , define defaultKey  = @"pk_test_CbJfLmFFADyn0piYUJIgr7MQ"
    if (![Stripe defaultPublishableKey]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Publishable Key"
                                                          message:@"Please specify a Stripe Publishable Key in Constants.m"
                                                         delegate:nil
                                                cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    [SVProgressHUD showWithStatus:@"Verified. Updating!"];
    STPCard *card = [[STPCard alloc] init];
    card.number = _paymentCell.paymentView.card.number;
    card.expMonth = _paymentCell.paymentView.card.expMonth;
    card.expYear = _paymentCell.paymentView.card.expYear;
    card.cvc = _paymentCell.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"Updated!"];
        if (error) {
            [self hasError:error];
        } else {
            _paymentCell.sCard = [card.number substringFromIndex:[card.number length] - 4] ;
            // [[PFUser currentUser] setObject:sCard forKey:@"sCard"];
            _paymentCell.sToken = token;
            //            [[PFUser currentUser] setObject:[token tokenId] forKey:@"sToken"];
            //            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //                if (!succeeded) {
            //                    NSLog(@"Error setting Stripe Token: %@", error);
            //                }
            //            }];
            //            NSDictionary *chargeParams = @{
            //                                           @"card": [token tokenId],
            //                                           @"objectId": [[PFUser currentUser] objectId]
            //                                           };
            //            [PFCloud callFunctionInBackground:@"register" withParameters:chargeParams block:^(id object, NSError *error) {
            //                NSLog(@"%@", error);
            //                [[PFUser currentUser] setObject:(NSString *)object forKey:@"sCustomerId"];
            //                [[PFUser currentUser] saveInBackground];
            //            }];
            _paymentCell.hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, _paymentCell.sCard];
            _paymentCell.hiddenCardLabel.hidden = NO;
            // _paymentCell.hiddenCardButton.hidden = NO;
            [self hasToken:token];
        }
    }];
    
    // Push to next controller
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token
{
    [SVProgressHUD showSuccessWithStatus:@"Updated!"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NMFoodsTableViewController *mainVC = [[NMFoodsTableViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
    return;
    
}

#pragma mark - NMRegisterPhoneTableViewCellDelegate methods

- (void)checkPhoneValid
{
    if ([_phoneCell.textField.text length] > 0) {
        [self paymentView:_paymentCell.paymentView withCard:_paymentCell.paymentView.card isValid:_paymentCell.paymentView.isValid];
    }
}

@end
