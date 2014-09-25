//
//  NMOrderFoodConfirmAddressCell.h
//  nommit
//
//  Created by Jarred Sumner on 9/17/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <M13Checkbox/M13Checkbox.h>

@interface NMOrderFoodConfirmAddressCell : UITableViewCell

@property (nonatomic, strong) M13Checkbox *checkbox;
@property (readonly) BOOL confirmed;

@end
