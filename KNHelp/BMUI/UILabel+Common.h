//
//  UILabel+Common.h
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

///创建label
+ (UILabel *)createLabelWithFont:(NSInteger)size;
+ (UILabel *)createLabelWithFont:(NSInteger)size textColor:(UIColor *)color;
+ (UILabel *)createLabelWithFont:(NSInteger)size text:(NSString *)text;
+ (UILabel *)createLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color;

///创建居中label
+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size;
+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size textColor:(UIColor *)color;
+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size text:(NSString *)text;
+ (UILabel *)createAlignmentCenterLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color;

///创建居右label
+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size;
+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size textColor:(UIColor *)color;
+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size text:(NSString *)text;
+ (UILabel *)createAlignmentRightLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color;

///创建居左label
+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size;
+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size textColor:(UIColor *)color;
+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size text:(NSString *)text;
+ (UILabel *)createAlignmentLeftLabelWithFont:(NSInteger)size text:(NSString *)text textColor:(UIColor *)color;

@end
