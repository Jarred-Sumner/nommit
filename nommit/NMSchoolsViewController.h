//
//  NMSchoolsVewController.h
//  nommit
//
//  Created by Jarred Sumner on 12/16/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMSchoolsViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) NMCompletionBlock completionBlock;

- (id)initWithCompletionBlock:(NMCompletionBlock)completionBlock;

@end
