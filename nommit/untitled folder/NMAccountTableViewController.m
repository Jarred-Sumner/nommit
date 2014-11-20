//
//  NMAccountTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAccountTableViewController.h"
#import "NMColors.h"
#import "NMTableSeparatorView.h"
#import "NMAccountInformationTableViewCell.h"
#import "NMAccountPromoTableViewCell.h"
#import "NMPaymentMethodTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMPaymentsViewController.h"
#import "NMLogoutButtonCell.h"
#import "NMLoginViewController.h"
#import "NMAppDelegate.h"
#import "NMNotificationSettingsTableViewCell.h"

@interface NMAccountTableViewController() <NSFetchedResultsControllerDelegate>

@property (readonly) NMUser *user;
@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMPaymentMethodTableViewCell *cardCell;
@property (nonatomic, strong) NMAccountPromoTableViewCell *promoCell;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMLogoutButtonCell *logoutCell;

@end

@implementation NMAccountTableViewController

const NSInteger NMAccountInformationSection = 0;
const NSInteger NMPaymentMethodSection = 1;
const NSInteger NMAccountPromoSection = 2;
const NSInteger NMNotificationSection = 3;
const NSInteger NMLogoutButtonSection = 4;

const NSInteger NMEmailRow = 0;
const NSInteger NMTextingRow = 1;
const NSInteger NMPushRow = 2;

static NSString *NMAccountInformationTableViewCellKey = @"NMAcountInformationTableViewCell";
static NSString *NMAccountPromoTableViewCellKey = @"NMAccountPromoTableViewCell";
static NSString *NMPaymentMethodTableViewCellKey = @"NMPaymentMethodTableViewCellKey";
static NSString *NMLogoutButtonTableViewCellKey = @"NMLogoutButtonTableViewCell";
static NSString *NMNotificationSettingsTableViewCellKey = @"NMNotificationSettingsTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initNavBar];
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInformationTableViewCellKey];
        [self.tableView registerClass:[NMAccountPromoTableViewCell class] forCellReuseIdentifier:NMAccountPromoTableViewCellKey];
        [self.tableView registerClass:[NMPaymentMethodTableViewCell class] forCellReuseIdentifier:NMPaymentMethodTableViewCellKey];
        [self.tableView registerClass:[NMLogoutButtonCell class] forCellReuseIdentifier:NMLogoutButtonTableViewCellKey];
        [self.tableView registerClass:[NMNotificationSettingsTableViewCell class] forCellReuseIdentifier:NMNotificationSettingsTableViewCellKey];
    }
    return self;
}

- (NMUser*)user {
    return [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == NMNotificationSection) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInformationSection) {
        return 76;
    } else if (indexPath.section == NMPaymentMethodSection) {
        return 65;
    } else if (indexPath.section == NMAccountPromoSection) {
        return 80;
    } else if (indexPath.section == NMLogoutButtonSection) {
        return 40;
    } else if (indexPath.section == NMNotificationSection) {
        return 54;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];
    if (section == NMAccountInformationSection) {
        separatorView.sectionLabel.text = @"ACCOUNT INFORMATION";
    } else if (section == NMPaymentMethodSection) {
        separatorView.sectionLabel.text = @"YOUR CARD";
    } else if (section == NMAccountPromoSection) {
        separatorView.sectionLabel.text = @"PROMOS";
    } else if (section == NMLogoutButtonSection) {
        return nil;
    } else if (section == NMNotificationSection) {
        separatorView.sectionLabel.text = @"NOTIFICATION SETTINGS";
    }
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInformationSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountInformationTableViewCellKey];
        [self configureCellForIndexPath:indexPath];
        return _infoCell;
    } else if (indexPath.section == NMPaymentMethodSection) {
        _cardCell = [self.tableView dequeueReusableCellWithIdentifier:NMPaymentMethodTableViewCellKey];
        [self configureCellForIndexPath:indexPath];
        return _cardCell;
    } else if (indexPath.section == NMAccountPromoSection) {
        _promoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountPromoTableViewCellKey];
        [self configureCellForIndexPath:indexPath];
        return _promoCell;
    } else if (indexPath.section == NMLogoutButtonSection) {
        _logoutCell = [self.tableView dequeueReusableCellWithIdentifier:NMLogoutButtonTableViewCellKey];
        [_logoutCell.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
        [_logoutCell.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        return _logoutCell;
    } else if (indexPath.section == NMNotificationSection) {
        NMNotificationSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMNotificationSettingsTableViewCellKey forIndexPath:indexPath];
        [self configureNotificationCell:cell withIndexPath:indexPath];
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == NMPaymentMethodSection) {
        NMPaymentsViewController *paymentsVC = [[NMPaymentsViewController alloc] init];
        [self.navigationController pushViewController:paymentsVC animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - submit button

- (void)submitPromoCode:(id)button {
    if (_promoCell.textField.text.length > 0) {
        __block NMAccountTableViewController *this = self;
        
        [SVProgressHUD showWithStatus:@"Applying..." maskType:SVProgressHUDMaskTypeBlack];
        [[NMApi instance] POST:[NSString stringWithFormat:@"users/%@/promos", self.user.facebookUID] parameters:@{ @"code" : _promoCell.textField.text } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
            [[Mixpanel sharedInstance] track:@"Applied Promo"];
            [SVProgressHUD showSuccessWithStatus:@"Applied!"];
            [this.tableView reloadData];
        }];
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"No Promo Code" andMessage:@"Please enter a promo code and try again"];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
    }

}

#pragma mark - nav bar

- (void)initNavBar
{
    self.title = @"Your Account";

    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - NSFetchedResultsController

- (void)configureCellForIndexPath:(NSIndexPath*)indexPath {
    NMUser *user = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    switch (indexPath.section) {
        case NMAccountInformationSection:
            _infoCell.avatar.profileID = user.facebookUID;
            _infoCell.nameLabel.text = user.fullName;
            _infoCell.emailLabel.text = user.email;
            _infoCell.phoneLabel.text = user.formattedPhone;
            break;
        case NMPaymentMethodSection:
            
            if ([user.lastFour length] > 0) {
                _cardCell.cardLabel.text = [NSString stringWithFormat:@"• • • • %@", user.lastFour];
                _cardCell.cardImage.image = [UIImage imageNamed:user.cardType];
            } else {
                _cardCell.cardLabel.text = @"• • • •";
            }
            break;
        case NMAccountPromoSection:
            [_promoCell.submitButton addTarget:self action:@selector(submitPromoCode:) forControlEvents:UIControlEventTouchUpInside];
            _promoCell.creditLabel.text = [NSString stringWithFormat:@"Account Credit: $%@\nShare your code with friends: %@", user.credit, user.referralCode];
            break;
        default:
            break;
    }

}

- (void)configureNotificationCell:(NMNotificationSettingsTableViewCell *)cell withIndexPath:(NSIndexPath*)indexPath {
    switch (indexPath.row) {
        case NMEmailRow:
            cell.titleLabel.text = @"Enable Email Notifications";
            break;
        case NMTextingRow:
            cell.titleLabel.text = @"Enable Text Notifications";
            break;
        case NMPushRow:
            cell.titleLabel.text = @"Enable Push Notifications";
            break;
        default:
            break;
    }
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"facebookUID == %@", NMSession.userID];
    _fetchedResultsController = [NMUser MR_fetchAllSortedBy:@"facebookUID" ascending:NO withPredicate:userPredicate groupBy:nil delegate:self];
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCellForIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)logout {
    _fetchedResultsController = nil;
    [NMSession logout];
}
@end
