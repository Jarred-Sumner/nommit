//
//  NMOrderLocationView.m
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderLocationView.h"
#import "NMColors.h"

@implementation NMOrderLocationView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NMColors mainColor];
    }
    return self;
}

@end
