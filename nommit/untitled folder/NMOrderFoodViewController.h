//
//  NMOrderFoodViewController.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFoodItem.h"

@interface NMOrderFoodViewController : UIViewController <UITableViewDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFoodItem:(NMFoodItem *)foodItem;

@end
