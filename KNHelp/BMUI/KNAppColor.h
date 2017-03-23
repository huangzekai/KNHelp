//
//  BMAppColor.h
//  Bemetoy
//  所有颜色相关的都写在这里
//  Created by kennyhuang on 15/10/9.
//  Copyright © 2015年 BM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///项目中出现多次的颜色放在这里，统一处理，以方便以后若要做换肤功能，提供一换肤配置文件来读取即可

@interface KNAppColor : NSObject
+ (UIColor *)appMainColor;
///导航栏背景颜色
+ (UIColor *)navigationBackgroundColor;
///导航栏标题颜色
+ (UIColor *)navigationTitleColor;
///tabbar背景色
+ (UIColor *)tabbarBgColor;
///控制器视图默认背景
+ (UIColor *)viewControllerBackgroundColor;
///灰色背景
+ (UIColor *)appGrayBgColor;
///线条默认颜色
+ (UIColor *)defaultLineColor;
///应用深橙色
+ (UIColor *)appDeepOrangeColor;
///应用浅橙色
+ (UIColor *)appLightOrangeColor;
///按钮normal状态颜色
+ (UIColor *)buttonNormalColor;
///按钮highlight状态颜色
+ (UIColor *)buttonHighlightColor;
///表格背景颜色
+ (UIColor *)tableViewBgColor;
///单元格背景颜色
+ (UIColor *)tableViewCellBgColor;
///textField字体颜色
+ (UIColor *)textFieldTextColor;
///textField Tint颜色
+ (UIColor *)textFieldTintColor;
///textField LeftLabel颜色
+ (UIColor *)textFieldLeftLabelColor;
///label标签字体颜色
+ (UIColor *)labelTextColor;
///图片默认背景
+ (UIColor *)pictureDefaultBgColor;
///黄色背景色
+ (UIColor *)yellowBgColor;
///深灰色背景色
+ (UIColor *)deepGrayBgColor;
///黄色字体
+ (UIColor *)yellowTextColor;
///浅灰色字体
+ (UIColor *)lightGrayTextColor;
///深灰色字体
+ (UIColor *)deepGrayTextColor;
///灰色字体
+ (UIColor *)normalGrayTextColor;
///红色字体
+ (UIColor *)defaultRedColor;
///首页背景色
+ (UIColor *)homePageBgColor;
@end
