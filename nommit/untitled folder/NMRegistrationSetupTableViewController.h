//
//  NMRegistrationSetupTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKView.h"
#import "NMRegisterPhoneTableViewCell.h"

@interface NMRegistrationSetupTableViewController : UITableViewController <NMRegisterPhoneTableViewCellDelegate>

- (IBAction)save:(id)sender;

@end
