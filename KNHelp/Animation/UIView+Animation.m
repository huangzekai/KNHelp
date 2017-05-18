//
//  UIView+Animation.m
//  KNHelp
//
//  Created by kennykhuang on 18/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

///抖动动画
- (void)startShakeAnimationWithDuration:(CGFloat)duration
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat tramsformX = self.transform.tx;
    
    animation.duration = duration;
    animation.values = @[@(tramsformX), @(tramsformX + 8), @(tramsformX - 8), @(tramsformX + 8), @(tramsformX - 5), @(tramsformX + 5), @(tramsformX)];
    animation.keyTimes = @[@(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:nil];
}

@end
