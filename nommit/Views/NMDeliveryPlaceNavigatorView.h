//
//  NMOrderLocationView.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger NMOrderLocationViewHeight = 54;

typedef NS_ENUM(NSInteger, NMDeliveryPlaceNavigatorDirection) {
    NMDeliveryPlaceNavigatorDirectionPrevious = -1,
    NMDeliveryPlaceNavigatorDirectionNext = 1,
};

@protocol NMDeliveryPlaceNavigatorDelegate <NSObject>

- (void)didNavigateToDeliveryPlaceAtIndex:(NSUInteger)index;
@end

@interface NMDeliveryPlaceNavigatorView : UIView

@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nextLabel;
@property (nonatomic, strong) UIButton *rightArrow;
@property (nonatomic, strong) UIButton *leftArrow;

@property (nonatomic, strong) NSArray *deliveryPlaces;

@property (nonatomic, strong) NSObject<NMDeliveryPlaceNavigatorDelegate> *delegate;

- (id)initWithFrame:(CGRect)frame deliveryPlaces:(NSArray*)deliveryPlaces;

- (void)startUpdating;
- (void)stopUpdating;

@end