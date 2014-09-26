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

@interface NMAccountTableViewController() <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMPaymentMethodTableViewCell *cardCell;
@property (nonatomic, strong) NMAccountPromoTableViewCell *promoCell;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NMAccountTableViewController

const NSInteger NMAccountInformationSection = 0;
const NSInteger NMPaymentMethodSection = 1;
const NSInteger NMAccountPromoSection = 2;

static NSString *NMAccountInformationTableViewCellKey = @"NMAcountInformationTableViewCell";
static NSString *NMAccountPromoTableViewCellKey = @"NMAccountPromoTableViewCell";
static NSString *NMPaymentMethodTableViewCellKey = @"NMPaymentMethodTableViewCellKey";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initNavBar];
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInformationTableViewCellKey];
        [self.tableView registerClass:[NMAccountPromoTableViewCell class] forCellReuseIdentifier:NMAccountPromoTableViewCellKey];
        [self.tableView registerClass:[NMPaymentMethodTableViewCell class] forCellReuseIdentifier:NMPaymentMethodTableViewCellKey];
        
        [self.fetchedResultsController performFetch:nil];
    }
    return self;
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
    if (indexPath.section == NMAccountInformationSection) {
        return 76;
    } else if (indexPath.section == NMPaymentMethodSection) {
        return 65;
    } else if (indexPath.section == NMAccountPromoSection) {
        return 75;
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

#pragma mark - submit button

- (void)submitPromoCode:(id)button
{
    NSString *promoCode = _promoCell.textField.text;
    NSLog(@"%@", promoCode);
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
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - NSFetchedResultsController

- (void)configureCellForIndexPath:(NSIndexPath*)indexPath {
    NMUser *user = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    switch (indexPath.section) {
        case NMAccountInformationSection:
            _infoCell.avatar.profileID = user.facebookUID;
            _infoCell.nameLabel.text = user.name;
            _infoCell.emailLabel.text = user.email;
            _infoCell.phoneLabel.text = user.formattedPhone;
            break;
        case NMPaymentMethodSection:
            if ([user.lastFour length] > 0) {
                _cardCell.cardLabel.text = [NSString stringWithFormat:@"• • • • %@", user.lastFour];
            } else {
                _cardCell.cardLabel.text = @"• • • •";
            }
            break;
        case NMAccountPromoSection:
            [_promoCell.submitButton addTarget:self action:@selector(submitPromoCode:) forControlEvents:UIControlEventTouchUpInside];
            _promoCell.creditLabel.text = [NSString stringWithFormat:@"Account Credit: $%@", user.referralCredit];
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

@end
