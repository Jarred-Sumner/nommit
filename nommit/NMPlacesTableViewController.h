//
//  NMLocationsTableViewController.h
//  nommit
//
//  Created by Jarred Sumner on 9/22/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFoodsTableViewController.h"

@interface NMPlacesTableViewController : UITableViewController <UISearchDisplayDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NMFoodsTableViewController *foodsVC;

@end
