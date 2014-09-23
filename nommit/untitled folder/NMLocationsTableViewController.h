//
//  NMLocationsTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "JCAutocompletingSearchViewController.h"

@protocol NMLocationsTableViewControllerDelegate <NSObject>

@required
- (void) setSelectedAddress:(NSString*)address;

@end

@interface NMLocationsTableViewController : UITableViewController

@property (nonatomic, strong) UISearchBar *searchBar;

@property id<NMLocationsTableViewControllerDelegate> delegate;

@end
