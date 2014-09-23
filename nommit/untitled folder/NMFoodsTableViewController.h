//
//  NMFoodsTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFoodsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMPlace *place;

- (id)initWithPlace:(NMPlace*)place;



@end
