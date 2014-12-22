//
//  NMBadgeView.h
//  nommit
//
//  Created by Jarred Sumner on 12/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMBadgeView : UIView

@property (nonatomic, strong) UIImageView *borderView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FBProfilePictureView *profileView;
@property (nonatomic, strong) UILabel *textLabel;

- (instancetype)initWithRadius:(CGFloat)radius image:(UIImage*)image;
- (instancetype)initWithRadius:(CGFloat)radius profileID:(NSString*)profileID;
- (instancetype)initWithRadius:(CGFloat)radius text:(NSString*)text;

@end
