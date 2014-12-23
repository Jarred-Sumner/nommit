//
//  NMDeliveryAvatarsTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>

@interface NMDeliveryAvatarsTableViewCell : UITableViewCell

@property (nonatomic, strong) TTTAttributedLabel *updateLabel;

-(void)setProfileID:(NSString*)profileID sellerImageURL:(NSURL*)sellerImageURL price:(NSNumber*)price;

@end
