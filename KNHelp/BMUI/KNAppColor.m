//
//  BMAppColor.m
//  Bemetoy
//  所有颜色相关的都写在这里
//  Created by kennyhuang on 15/10/9.
//  Copyright © 2015年 BM. All rights reserved.
//

#import "KNAppColor.h"

const static NSUInteger NAVIGATIONBAR_BG_COLOR = 0xff8903;
const static NSUInteger NAVIGATIONBAR_TITLE_COLOR = 0xffffff;
const static NSUInteger DEFAULT_LINE_COLOR = 0xd6d8df;
const static NSUInteger APP_LIGHT_ORANGE_COLOR = 0XFF8903;
const static NSUInteger TABBAR_BG_COLOR = 0x272727;
const static NSUInteger VIEWCONTROLLER_BG_COLOR = 0xFFEF94;
const static NSUInteger TEXTFIELD_TEXTCOLOR = 0x999999;
const static NSUInteger TEXTFIELD_TEXT_LEFT_LABLE_COLOR = 0x808080;
const static NSUInteger TEXTFIELD_TINTCOLOR = 0x999999;
const static NSUInteger PICTURE_DEFAULT_BG_COLOR = 0xf5f5f5;
const static NSUInteger YELLOW_BG_COLOR = 0xfffaec;
const static NSUInteger YELLOW_TEXT_COLOR = 0xffbe3b;
const static NSUInteger APP_DEEP_ORANGE_COLOR = 0xef5b37;
const static NSUInteger APP_GRAY_BG_COLOR = 0xf8f8f8;
const static NSUInteger TEXT_LIGHT_GRAY_COLOR = 0x999999;
const static NSUInteger TEXT_DEEP_GRAY_COLOR = 0x333333;
const static NSUInteger TEXT_NORMAL_GRAY_COLOR = 0x666666;
const static NSUInteger DEFAULT_RED_COLOR = 0xc83931;
const static NSUInteger APP_DEEP_GRAY_COLOR = 0xe5e5e5;
const static NSUInteger HOME_PAGE_BG_COLOR = 0xfcfcfc;

@implementation KNAppColor


+ (UIColor *)appMainColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_BG_COLOR];
}


///导航栏背景颜色
+ (UIColor *)navigationBackgroundColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_BG_COLOR alpha:0.35];
}

///导航栏标题颜色
+ (UIColor *)navigationTitleColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_TITLE_COLOR];
}

///tabbar背景色
+ (UIColor *)tabbarBgColor
{
    return [UIColor colorWithUInt:TABBAR_BG_COLOR];
}

///控制器视图默认背景
+ (UIColor *)viewControllerBackgroundColor
{
    return [UIColor colorWithUInt:VIEWCONTROLLER_BG_COLOR];
}

///灰色背景
+ (UIColor *)appGrayBgColor
{
    return [UIColor colorWithUInt:APP_GRAY_BG_COLOR];
}

///线条默认颜色
+ (UIColor *)defaultLineColor
{
    return [UIColor colorWithUInt:DEFAULT_LINE_COLOR];
}

///应用深橙色
+ (UIColor *)appDeepOrangeColor
{
    return [UIColor colorWithUInt:APP_DEEP_ORANGE_COLOR];
}

///应用浅橙色
+ (UIColor *)appLightOrangeColor
{
    return [UIColor colorWithUInt:APP_LIGHT_ORANGE_COLOR];
}

///按钮normal状态颜色
+ (UIColor *)buttonNormalColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_TITLE_COLOR];
}

///按钮highlight状态颜色
+ (UIColor *)buttonHighlightColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_TITLE_COLOR];
}

///表格背景颜色
+ (UIColor *)tableViewBgColor
{
    return [UIColor colorWithUInt:DEFAULT_LINE_COLOR];
}

///单元格背景颜色
+ (UIColor *)tableViewCellBgColor
{
    return [UIColor clearColor];
}

///textField字体颜色
+ (UIColor *)textFieldTextColor
{
    return [UIColor colorWithUInt:TEXTFIELD_TEXTCOLOR alpha:0.5];
}

+ (UIColor *)textFieldLeftLabelColor
{
    return [UIColor colorWithUInt:TEXTFIELD_TEXT_LEFT_LABLE_COLOR];
}

///textField Tint颜色
+ (UIColor *)textFieldTintColor
{
    return [UIColor colorWithUInt:TEXTFIELD_TINTCOLOR alpha:0.5];
}

///label标签字体颜色
+ (UIColor *)labelTextColor
{
    return [UIColor colorWithUInt:NAVIGATIONBAR_TITLE_COLOR];
}

///图片默认背景
+ (UIColor *)pictureDefaultBgColor
{
    return [UIColor colorWithUInt:PICTURE_DEFAULT_BG_COLOR];
}

///黄色背景色
+ (UIColor *)yellowBgColor
{
    return [UIColor colorWithUInt:YELLOW_BG_COLOR];
}

///深灰色背景色
+ (UIColor *)deepGrayBgColor
{
    return [UIColor colorWithUInt:APP_DEEP_GRAY_COLOR];
}

///黄色字体
+ (UIColor *)yellowTextColor
{
    return [UIColor colorWithUInt:YELLOW_TEXT_COLOR];
}

///浅灰色字体
+ (UIColor *)lightGrayTextColor
{
    return [UIColor colorWithUInt:TEXT_LIGHT_GRAY_COLOR];
}

///深灰色字体
+ (UIColor *)deepGrayTextColor
{
    return [UIColor colorWithUInt:TEXT_DEEP_GRAY_COLOR];
}

///灰色字体
+ (UIColor *)normalGrayTextColor
{
    return [UIColor colorWithUInt:TEXT_NORMAL_GRAY_COLOR];
}

///红色字体
+ (UIColor *)defaultRedColor
{
    return [UIColor colorWithUInt:DEFAULT_RED_COLOR];
}

///首页背景色
+ (UIColor *)homePageBgColor
{
    return [UIColor colorWithUInt:HOME_PAGE_BG_COLOR];
}

@end
