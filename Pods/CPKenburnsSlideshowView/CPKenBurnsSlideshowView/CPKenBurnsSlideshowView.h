//
//  CPKenburnsSlideshowView.h
//  CPKenburnsSlideshowView-Demo
//
//  Created by Muukii on 4/7/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPKenburnsView.h"
@class CPKenburnsImage;
@class CPKenburnsView;

typedef void(^DownloadCompletionBlock)(UIImage *image);

@protocol CPKenburnsSlideshowViewDeleagte;
@interface CPKenburnsSlideshowView : UIView
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, assign) id <CPKenburnsSlideshowViewDeleagte> delegate;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) BOOL slideshow; //Auto paging
@property (nonatomic, assign) CGFloat slideshowDuration; // default 10.f
@property (nonatomic, assign) CGFloat automaticFadeDuration; // default 1.5f
@property (nonatomic, assign) Class titleViewClass;
@property (nonatomic, assign) BOOL longTapGestureEnable;
- (void)stopAnimation;
- (void)restartAnimation;

- (NSInteger)currentIndex;

- (void)addImage:(CPKenburnsImage *)image;
- (void)jumpToIndex:(NSInteger)index;

#warning TODO
- (void)jumpToIndex:(NSInteger)index animated:(BOOL)animated;

- (CPKenburnsView *)currentKenburnsView;
- (CPKenburnsView *)nextKenburnsView;
- (CPKenburnsView *)previousKenburnsView;




@end

@protocol CPKenburnsSlideshowViewDeleagte <NSObject>
@optional
- (void)slideshowView:(CPKenburnsSlideshowView *)slideshowView downloadImageUrl:(NSURL *)imageUrl completionBlock:(DownloadCompletionBlock)completionBlock;
- (void)slideshowView:(CPKenburnsSlideshowView *)slideshowView downloadImageUrl:(NSURL *)imageUrl kenburnsView:(CPKenburnsView *)kenburnsView;
- (void)slideshowView:(CPKenburnsSlideshowView *)slideshowView willShowKenburnsView:(CPKenburnsView *)kenBurnsView;


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end