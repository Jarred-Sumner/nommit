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
#import "NMYourCardsTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMPaymentsViewController.h"

@interface NMAccountTableViewController ()

@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMYourCardsTableViewCell *cardCell;
@property (nonatomic, strong) NMAccountPromoTableViewCell *promoCell;

@end

@implementation NMAccountTableViewController

const NSInteger NMAccountInformationSection = 0;
const NSInteger NMYourCardsSection = 1;
const NSInteger NMAccountPromoSection = 2;

static NSString *NMAccountInformationTableViewCellKey = @"NMAcountInformationTableViewCell";
static NSString *NMAccountPromoTableViewCellKey = @"NMAccountPromoTableViewCell";
static NSString *NMYourCardsTableViewCellKey = @"NMYourCardsTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initNavBar];
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInformationTableViewCellKey];
        [self.tableView registerClass:[NMAccountPromoTableViewCell class] forCellReuseIdentifier:NMAccountPromoTableViewCellKey];
        [self.tableView registerClass:[NMYourCardsTableViewCell class] forCellReuseIdentifier:NMYourCardsTableViewCellKey];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (indexPath.section == NMAccountInformationSection) {
        return 76;
    } else if (indexPath.section == NMYourCardsSection) {
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
    } else if (section == NMYourCardsSection) {
        separatorView.sectionLabel.text = @"YOUR CARDS";
    } else if (section == NMAccountPromoSection) {
        separatorView.sectionLabel.text = @"PROMOS";
    }
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInformationSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountInformationTableViewCellKey];
        
        _infoCell.nameLabel.text = @"Lucy Guo";
        _infoCell.emailLabel.text = @"lucyguo@cmu.edu";
        _infoCell.phoneLabel.text = @"(925) 596 8005";
        return _infoCell;
    } else if (indexPath.section == NMYourCardsSection) {
        _cardCell = [self.tableView dequeueReusableCellWithIdentifier:NMYourCardsTableViewCellKey];
        _cardCell.cardLabel.text = @"● ● ● ● 4242";
        
        return _cardCell;
    } else if (indexPath.section == NMAccountPromoSection) {
        _promoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountPromoTableViewCellKey];
        [_promoCell.submitButton addTarget:self action:@selector(submitPromoCode:) forControlEvents:UIControlEventTouchUpInside];
        _promoCell.creditLabel.text = @"Account Credit: $25";
        return _promoCell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == NMYourCardsSection) {
        NMPaymentsViewController *paymentsVC = [[NMPaymentsViewController alloc] init];
        [self.navigationController pushViewController:paymentsVC animated:YES];
    }
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
@end
