//
//  NMMenuViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>


@interface NMMenuViewController : UITableViewController <NSFetchedResultsControllerDelegate>

- (void)showMenu;
- (void)showSupport;
- (void)showInvite;
- (void)showAccount;
- (void)showOrders;

- (void)openDeliveriesPage;
- (void)showDeliveryPageForOrder:(NMOrder*)order;


@end
