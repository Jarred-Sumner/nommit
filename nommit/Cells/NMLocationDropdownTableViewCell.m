//
//  NMLocationDropdownTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationDropdownTableViewCell.h"
#import "NMColors.h"

@implementation NMLocationDropdownTableViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NMColors mainColor];
    }
    return self;
}

@end
