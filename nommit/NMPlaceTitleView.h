//
//  NMPlaceTitleView.h
//  nommit
//
//  Created by Jarred Sumner on 1/2/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface NMPlaceTitleView : UIView

@property (nonatomic, strong) TTTAttributedLabel *titleLabel;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title target:(id)target selector:(SEL)selector;
- (void)setTitle:(NSString*)title;

@end
