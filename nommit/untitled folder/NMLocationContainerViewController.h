//
//  NMLocationContainerViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMLocationContainerViewControllerDelegate <NSObject>

@required
- (void) setSelectedAddress: (NSString*)address;

@end

@interface NMLocationContainerViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    BOOL shouldBeginEditing;
    NSMutableArray *searchResultsPlaces;
}

@property id<NMLocationContainerViewControllerDelegate> delegate;

@end
