//
//  NMCollectionViewSmallLayout.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCollectionViewSmallLayout.h"

@interface NMCollectionViewSmallLayout ()

@end

@implementation NMCollectionViewSmallLayout

- (id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(142, 187);
    self.sectionInset = UIEdgeInsetsMake(0, 9, 0, 9);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 9.0f;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return NO;
}

@end
