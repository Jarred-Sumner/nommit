//
//  NMPickPlacesTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMDeliveryPlacesTableViewController : UITableViewController<UISearchDisplayDelegate, NSFetchedResultsControllerDelegate>

- (id)initWithShift:(NMShift*)shift;

@end
