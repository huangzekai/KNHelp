//
//  UIImageView+Common.m
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)

+ (UIImageView *)createImageView
{
    UIImageView *imageView =  [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    return imageView;
}

+ (UIImageView *)createImageViewWithRadius:(CGFloat)radius
{
    UIImageView *imageView = [UIImageView createImageView];
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    
    return imageView;
}

@end
