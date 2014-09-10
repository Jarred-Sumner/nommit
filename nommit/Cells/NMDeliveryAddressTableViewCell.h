//
//  NMDeliveryAddressTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMDeliveryAddressTableViewCell;

@interface NMDeliveryAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) UILabel *currentAddress;
@property (nonatomic, strong) UILabel *estimatedTime;
@property (nonatomic, weak) id<NMDeliveryAddressTableViewCell> delegate;

@end

@protocol CMDeliveryAddressTableViewCell

@required

-(void)addressButtonPressed:(id)sender;

@end



