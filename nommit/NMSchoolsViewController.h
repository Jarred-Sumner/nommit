//
//  NMSchoolsVewController.h
//  nommit
//
//  Created by Jarred Sumner on 12/16/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NMSchoolsCompletionBlock)();

@interface NMSchoolsViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) NMSchoolsCompletionBlock completionBlock;

- (id)initWithCompletionBlock:(NMSchoolsCompletionBlock)completionBlock;

@end
