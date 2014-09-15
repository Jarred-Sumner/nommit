//
//  NMRateViewController.h
//  nommit
//
//  Created by Lucy Guo on 9/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@protocol NMRateViewControllerDelegate;

@interface NMRateViewController : UIViewController<RateViewDelegate> {
}

@property (nonatomic, weak) id<NMRateViewControllerDelegate> delegate;
@property (nonatomic, strong) RateView* rateVw;

- (id)initWithPrice:(NSString *)price;

@end

@protocol NMRateViewControllerDelegate

@required

-(void)ratingDoneButtonPressed:(id)sender;
-(void)updateRating:(float)rating;

@end