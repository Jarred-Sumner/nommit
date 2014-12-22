//
//  NMPaymentsViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/8/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKView.h"

@interface NMPaymentsViewController : UITableViewController

- (instancetype)initWithCompletionBlock:(NMCompletionBlock)completionBlock;

@end
