//
//  UIImageView+Common.h
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Common)

+ (UIImageView *)createImageView;
+ (UIImageView *)createImageViewWithRadius:(CGFloat)radius;
+ (UIImageView *)createImageWithSingleTapAction:(SEL)action;
- (void)addSingleTapAction:(SEL)action;


@end
