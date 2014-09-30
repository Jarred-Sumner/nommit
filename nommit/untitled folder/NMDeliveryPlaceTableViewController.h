//
//  NMFoodOrdersTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMDeliveryPlaceTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (readonly) NMPlace *place;
@property (nonatomic, strong) NSArray *places;

@end
