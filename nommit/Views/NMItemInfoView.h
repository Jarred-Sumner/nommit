//
//  NMItemInfoView.h
//  nommit
//
//  Created by Lucy Guo on 8/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMItemInfoView : UIView

- (id)initWithFrame:(CGRect)frame withItemName:(NSString *)name withItemDescription:(NSString *)itemDescription withPrice:(NSUInteger)price;

@end
