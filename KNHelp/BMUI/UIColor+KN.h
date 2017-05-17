//
//  UIColor+BM.h
//
//
//  Created by kennyhuang on 15/10/9.
//  Copyright © 2015年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KN)

///根据十六进制rgb值获取颜色
+ (UIColor *)colorWithUInt:(NSUInteger)rgbHex;

+ (UIColor *)colorWithUInt:(NSUInteger)rgbHex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end
