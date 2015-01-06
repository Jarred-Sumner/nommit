	//
//  NMFoodsTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFoodsTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMPlace *place;

- (id)initWithPlace:(NMPlace*)place;

@property (readonly) BOOL hasFoods;


@end
