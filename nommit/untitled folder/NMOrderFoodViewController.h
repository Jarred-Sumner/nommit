//
//  NMOrderFoodViewController.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMAddressSearchViewController.h"
#import "NMOrderFoodProgressCell.h"

@interface NMOrderFoodViewController : UITableViewController<NMAddressSearchDelegate, NMOrderFoodProgressCell>

@property (nonatomic, strong) NMOrderApiModel *orderModel;

- (id)initWithFood:(NMFood*)food;

@end
