//
//  UIScrollView+NMParallaxHeader.m
//  nommit
//
//  Created by Lucy Guo on 9/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "UIScrollView+NMParallaxHeader.h"
#import "UIScrollView+APParallaxHeader.h"


@implementation UIScrollView (NMParallaxHeader)

- (void)addParallaxWithImageSubviewed:(UIImage *)image andHeight:(CGFloat)height andShadow:(BOOL)shadow {
    if(self.parallaxView) {
        if(self.parallaxView.currentSubView) {
            [self.parallaxView.currentSubView removeFromSuperview];
        }
        [self.parallaxView.imageView setImage:image];
    }
    else
    {
        APParallaxView *view = [[APParallaxView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height) andShadow:shadow];
        [view setClipsToBounds:YES];
        [view.imageView setImage:image];
        
        view.scrollView = self;
        view.parallaxHeight = height;
        [self insertSubview:view atIndex:0];
        
        view.originalTopInset = self.contentInset.top;
        
        UIEdgeInsets newInset = self.contentInset;
        newInset.top = height;
        self.contentInset = newInset;
        
        self.parallaxView = view;
        self.showsParallax = YES;
    }
}

- (void)addTitleToParallaxView:(NSString *)title
{
    UILabel *eventName = [[UILabel alloc] init];
    eventName.text = title;
    eventName.font = [UIFont fontWithName:@"Avenir" size:20];
    eventName.textColor = [UIColor whiteColor];
    eventName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.parallaxView addSubview:eventName];
    
    [self.parallaxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-106-[eventName]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(eventName)]];
    
    [self.parallaxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[eventName]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(eventName)]];
}

- (void)addBlackOverlayToParallaxView
{
    UIView *blackOverlay = [[UIView alloc] init];
    blackOverlay.backgroundColor = [UIColor blackColor];
    blackOverlay.alpha = .15f;
    blackOverlay.translatesAutoresizingMaskIntoConstraints = NO;
    blackOverlay.clipsToBounds = YES;
    [self insertSubview:blackOverlay atIndex:0];
    [self.parallaxView addSubview:blackOverlay];
    
    [self.parallaxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blackOverlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blackOverlay)]];
    
    [self.parallaxView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blackOverlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blackOverlay)]];
}

@end
