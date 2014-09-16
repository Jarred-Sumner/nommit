//
//  NMPersonalCampaignViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFoodItem.h"
#import "NMOrderFoodViewController.h"

@interface NMPersonalCampaignViewController : NMOrderFoodViewController

- (id)initWithCampaign:(NMFoodItem *)campaign;


@end
