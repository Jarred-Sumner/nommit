//
//  NMFoodViewController.h
//  nommit
//
//  Created by Jarred Sumner on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>

@interface NMFoodsViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, REFrostedViewControllerDelegate>

@property (nonatomic, readonly, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic, readonly, getter=isTransitioning) BOOL transitioning;
@property (nonatomic, strong) NSArray *galleryImages;

@end
