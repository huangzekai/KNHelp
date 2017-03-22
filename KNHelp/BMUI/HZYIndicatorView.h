//
//  HZYIndicatorView.h
//  test
//
//  Created by jacky on 16/7/22.
//  Copyright © 2016年 com.bemetoy.Bemetoy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    kIndicatorStyleDefault,   ///默认，整个菊花都会转的效果
    kIndicatorStyleSystem,   ///系统样式，未完成
} kIndicatorStyle;


@interface HZYIndicatorView : UIView

@property(nonatomic,assign) kIndicatorStyle style;
@property(nonatomic,strong) UIColor *lineColor; //default is blackColor
@property(nonatomic,assign) BOOL opacity; //default is NO, if set YES, opacity value default from 0.0 to 1.0
@property(nonatomic,assign) CGPoint opacityRange; //useless when opacity is NO, this value describe the range where opacity value take from, for example , if you want all petal is 0.5 opacity, you can set {0.5,0.5}

- (void)drawChrysanthemumWithPoint:(CGPoint)centerPoint radius:(CGFloat)radius petalNum:(NSUInteger)number petalLength:(CGFloat)length;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimation;

@end
