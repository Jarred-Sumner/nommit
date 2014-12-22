//
//  NMFoodOrdersTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMDeliveryPlaceHeaderView.h"
#import "NMDeliveryPlacesTableViewController.h"


@interface NMShiftTableViewController:UIViewController<UITableViewDataSource, UITableViewDelegate, NMDeliveryPlaceHeaderViewDelegate>

@property (nonatomic, strong) NMShiftApiModel *shift;

- (id)initWithShift:(NMShiftApiModel*)shift;
@end
