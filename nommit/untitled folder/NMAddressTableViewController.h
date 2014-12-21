//
//  NMAddressTableViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/4/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class SPGooglePlacesAutocompleteQuery;

@interface NMAddressTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    MKPointAnnotation *selectedPlaceAnnotation;
    BOOL shouldBeginEditing;
}

@property (nonatomic, strong) UISearchBar *searchBar;

@end
