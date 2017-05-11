//
//  UILabel+Common.m
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

+ (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightTextColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)createLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel createLabel];
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)createLabelWithFont:(NSInteger)size textColor:(UIColor *)color
{
    UILabel *label = [UILabel createLabelWithFont:size];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)createLabelWithFont:(NSInteger)size text:(NSString *)text
{
    UILabel *label = [UILabel createLabelWithFont:size];
    label.text = text;
    
    return label;
}

+ (UILabel *)createLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color
{
    UILabel *label = [UILabel createLabelWithFont:size text:text];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel createLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size textColor:(UIColor *)color
{
    UILabel *label = [UILabel createAlignmentCenterLabelWithFont:size];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size text:(NSString *)text
{
    UILabel *label = [UILabel createAlignmentCenterLabelWithFont:size];
    label.text = text;
    
    return label;
}

+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color
{
    UILabel *label = [UILabel createAlignmentCenterLabelWithFont:size text:text];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel createLabel];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size textColor:(UIColor *)color
{
    UILabel *label = [UILabel createAlignmentRightLabelWithFont:size];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size text:(NSString *)text
{
    UILabel *label = [UILabel createAlignmentRightLabelWithFont:size];
    label.text = text;
    
    return label;
}

+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size
{
    UILabel *label = [UILabel createLabel];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}

+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size text:(NSString *)text
{
    UILabel *label = [UILabel createAlignmentLeftLabelWithFont:size];
    label.text = text;
    
    return label;
}

+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color
{
    UILabel *label = [UILabel createAlignmentLeftLabelWithFont:size text:text];
    label.textColor = color;
    
    return label;
}

@end
