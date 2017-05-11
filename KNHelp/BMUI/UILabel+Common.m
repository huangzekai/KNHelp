//
//  UILabel+Common.m
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

+ (UILabel *)obtainLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightTextColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    return label;
}

+ (UILabel *)obtainLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel obtainLabel];
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)obtainAlignmentCenterLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel obtainLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)obtainAlignmentRightLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel obtainLabel];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)obtainAlignmentLeftLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel obtainLabel];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

@end
