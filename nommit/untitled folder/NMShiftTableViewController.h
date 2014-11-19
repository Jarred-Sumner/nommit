//
//  NMFoodOrdersTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMDeliveryPlaceHeaderView.h"
#import "NMDeliveryPlacesTableViewController.h"


@interface NMShiftTableViewController:UIViewController<UITableViewDataSource, UITableViewDelegate, NMDeliveryPlaceHeaderViewDelegate, NMDeliveryPlacesTableViewControllerDelegate>

@property (nonatomic, strong) NSNumber *shiftID;

- (id)initWithShiftID:(NSNumber*)shiftID;
@end
