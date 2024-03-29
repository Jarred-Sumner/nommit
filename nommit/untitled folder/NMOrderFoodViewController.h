//
//  NMOrderFoodViewController.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMAddressSearchViewController.h"
#import "NMOrderFoodProgressCell.h"
#import "NMOrderFoodBasicInfoTableViewCell.h"

@interface NMOrderFoodViewController : UITableViewController<NMAddressSearchDelegate, NMOrderFoodBasicInfoTableViewCellDelegate>

@property (nonatomic, strong) NMOrderApiModel *orderModel;

- (id)initWithFood:(NMFood*)food place:(NMPlace*)place;

@end
