//
//  NMOrderFoodViewController.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFoodItem.h"
#import "NMAddressSearchViewController.h"

@interface NMOrderFoodViewController : UITableViewController<NMAddressSearchDelegate>

- (id)initWithFoodItem:(NMFoodItem *)foodItem;

@end
