//
//  NMBadgeView.m
//  nommit
//
//  Created by Jarred Sumner on 12/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMBadgeView.h"

@interface NMBadgeView ()

@property CGFloat radius;

@end

@implementation NMBadgeView

#pragma mark - Initialization

- (instancetype)initWithRadius:(CGFloat)radius image:(UIImage*)image {
    self = [self init];
    
    [self setupImageView];
    self.imageView.image = image;
    
    [self addConstraintForView:self.imageView radius:radius];
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius profileID:(NSString*)profileID {
    self = [self init];
    
    [self setupProfileView];
    self.profileView.profileID = profileID;
    
    [self addConstraintForView:self.profileView radius:radius];
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius text:(NSString*)text {
    self = [self init];
    
    [self setupTextLabel];
    self.textLabel.text = text;
    
    
    [self addConstraintForView:self.textLabel radius:radius];
    return self;
}

- (instancetype)init {
    self = [super init];

    self.backgroundColor = [NMColors mainColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self setupBorderView];
    return self;
}

#pragma mark - Setup Views

- (void)setupImageView {
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoadingSeller"]];
    _imageView.layer.masksToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_imageView];
}

- (void)setupProfileView {
    _profileView = [[FBProfilePictureView alloc] init];
    _profileView.layer.masksToBounds = YES;
    _profileView.pictureCropping = FBProfilePictureCroppingSquare;
    _profileView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_profileView];
}

- (void)setupBorderView {
    _borderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AvatarBorder"]];
    _borderView.layer.masksToBounds = YES;
    _borderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_borderView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_borderView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_borderView)]];
}

- (void)setupTextLabel {
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont fontWithName:@"Avenir" size:28];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _textLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:_textLabel];
    
    [_textLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_textLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - Utility Methods

- (void)addConstraintForView:(UIView*)view radius:(CGFloat)radius {
    NSString *formatX = [NSString stringWithFormat:@"H:|-5-[view(%@)]-5-|", @(radius * 2)];
    NSString *formatY = [NSString stringWithFormat:@"V:|-5-[view(%@)]-5-|", @(radius * 2)];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatX options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatY options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}

@end
