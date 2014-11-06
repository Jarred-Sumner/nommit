//
//  NMFoodOrdersTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMDeliveryPlaceHeaderView.h"

@interface NMShiftTableViewController:UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, NMDeliveryPlaceHeaderViewDelegate>

@property (nonatomic, strong) NMShift *shift;

- (id)initWithShift:(NMShift*)shift;

@end
