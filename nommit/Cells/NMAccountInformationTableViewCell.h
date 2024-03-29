//
//  NMAccountInformationTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMAccountInformationTableViewCell : UITableViewCell

@property (nonatomic, strong) FBProfilePictureView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@end
