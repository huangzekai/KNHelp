//
//  UILabel+Common.h
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

///创建居左label
+ (UILabel *)obtainLabelWithFont:(NSInteger)size;

///创建居中label
+ (UILabel *)obtainAlignmentCenterLabelWithFont:(NSInteger)size;

///创建居右label
+ (UILabel *)obtainAlignmentRightLabelWithFont:(NSInteger)size;

///创建居左label
+ (UILabel *)obtainAlignmentLeftLabelWithFont:(NSInteger)size;

@end
