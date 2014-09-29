//
//  NMFoodOrdersTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFoodDeliveryPlaceTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (readonly) NMPlace *place;
@property (nonatomic, strong) NSMutableSet *places;

@end
