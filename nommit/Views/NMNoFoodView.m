//
//  NMNoFoodView.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMNoFoodView.h"

@implementation NMNoFoodView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChefIcon];
        [self setupLabel];
    }
    return self;
}

- (void)setupChefIcon {
    UIImageView *chef = [[UIImageView alloc] init];
    chef.translatesAutoresizingMaskIntoConstraints = NO;
    chef.image = [UIImage imageNamed:@"Chef"];
    chef.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:chef];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-78-[chef]-78-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chef)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-101-[chef]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chef)]];
}

- (void)setupLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH::mm a";
    
    NSPredicate *startPredicate = [NSPredicate predicateWithFormat:@"startDate > %@", [NSDate date]];
    NMFood *food = [NMFood MR_findFirstWithPredicate:startPredicate sortedBy:@"startDate" ascending:YES];
    
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont fontWithName:@"Avenir" size:16];
    label.textColor = UIColorFromRGB(0xB2B2B2);

    if (food) {
        label.text = [NSString stringWithFormat:@"No food available right now. Please check back between %@ and %@!", [formatter stringFromDate:food.startDate], [formatter stringFromDate:food.endDate]];
    } else {
        label.text = @"No food available right now. Please check back tonight!";
    }

    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 3;
    
    [self addSubview:label];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-54-[label]-54-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-28-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
}

@end
