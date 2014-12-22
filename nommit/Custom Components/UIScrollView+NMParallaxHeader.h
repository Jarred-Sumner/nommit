//
//  UIScrollView+NMParallaxHeader.h
//  nommit
//
//  Created by Lucy Guo on 9/30/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"

@interface UIScrollView (NMParallaxHeader)

- (void)addTitleToParallaxView:(NSString *)title;
- (void)addBlackOverlayToParallaxView;

@end
