//
//  NMOrderLocationView.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger NMOrderLocationViewHeight = 54;

@protocol NMFoodDeliveryPlaceNavigatorDelegate <NSObject>

- (void)didChangeFoodDeliveryPlace:(NMFoodDeliveryPlace*)deliveryPlace;

@end

@interface NMFoodDeliveryPlaceNavigatorView : UIView

@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nextLabel;
@property (nonatomic, strong) UIButton *rightArrow;
@property (nonatomic, strong) UIButton *leftArrow;

@property (nonatomic, strong) NSArray *deliveryPlaces;

@property (nonatomic, strong) NSObject<NMFoodDeliveryPlaceNavigatorDelegate> *delegate;

@end