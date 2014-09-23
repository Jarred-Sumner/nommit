  //
//  NMAddressSearchViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class SPGooglePlacesAutocompleteQuery;

@protocol NMAddressSearchDelegate <NSObject>

@required
- (void) setSelectedAddress: (NSString*)address;

@end

@interface NMAddressSearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    BOOL shouldBeginEditing;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    NSArray *searchResultsPlaces;
}

@property id<NMAddressSearchDelegate> delegate;

@end
