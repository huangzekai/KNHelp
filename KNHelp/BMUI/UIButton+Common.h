//
//  UIButton+Common.h
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KNImagePosition) {
    KNImagePositionLeft = 0,              //图片在左，文字在右，默认
    KNImagePositionRight = 1,             //图片在右，文字在左
    KNImagePositionTop = 2,               //图片在上，文字在下
    KNImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (Common)

+ (UIButton *)createButtonWithTitle:(NSString *)title Target:(id)target action:(SEL)action;

+ (UIButton *)createButtonWithRadius:(CGFloat)radius title:(NSString *)title;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)knSetImagePosition:(KNImagePosition)postion spacing:(CGFloat)spacing;

@end
