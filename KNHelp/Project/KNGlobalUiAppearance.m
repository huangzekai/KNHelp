//
//  KNGlobalUiAppearance.m
//  Bemetoy
//  全局UI设置
//  Created by kennyhuang on 15/10/9.
//  Copyright © 2015年 KN. All rights reserved.
//

#import "KNGlobalUiAppearance.h"

@implementation KNGlobalUiAppearance

///初始化整体UI外观
+ (void)initMainUiAppearance
{
    //状态栏
    [KNGlobalUiAppearance statusBarAppStyle];
    //导航栏
    [KNGlobalUiAppearance navigationBarAppStyle];
    //导航栏按钮
    [KNGlobalUiAppearance navigationItemAppStyle];
    ///tabbar
    [KNGlobalUiAppearance tabbarItemAppStyle];
    //表格
    [KNGlobalUiAppearance tableviewAppStyle];
    //单元格
    [KNGlobalUiAppearance tableViewCellAppStyle];
    //textField
//    [KNGlobalUiAppearance textFieldAppStyle];
    //标签
    [KNGlobalUiAppearance labelAppStyle];
    //按钮
    [KNGlobalUiAppearance buttonAppStyle];
}

///状态栏
+ (void)statusBarAppStyle
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

///导航栏风格
+ (void)navigationBarAppStyle
{
    UIColor *navBgColor = [KNAppColor navigationBackgroundColor];
    UIColor *navTitleColor = [KNAppColor navigationTitleColor];
    [[UINavigationBar appearance] setBarTintColor:navBgColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *titleDictionary = @{NSForegroundColorAttributeName : navTitleColor,
                                      NSFontAttributeName : [KNAppFont navigationTitleFont]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleDictionary];
}

///导航栏按钮风格
+ (void)navigationItemAppStyle
{
    UIColor *navTitleColor = [KNAppColor navigationTitleColor];
    NSDictionary *itemDictionary = @{NSForegroundColorAttributeName : navTitleColor,
                                     NSFontAttributeName : [KNAppFont navigationItemFont]};
    NSDictionary *navBarDictionary = @{NSForegroundColorAttributeName:navTitleColor,
                                       NSFontAttributeName:[KNAppFont navigationItemFont]};
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:itemDictionary forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:navBarDictionary forState:UIControlStateHighlighted];
}

///tabbar风格
+ (void)tabbarItemAppStyle
{
    UIColor *normalColor = [KNAppColor appDeepOrangeColor];
    UIColor *selectColor = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:normalColor, NSForegroundColorAttributeName,nil];
    NSDictionary *selectedDict = [NSDictionary dictionaryWithObjectsAndKeys:selectColor, NSForegroundColorAttributeName,nil];
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectedDict forState:UIControlStateHighlighted];
    [tabbarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

///表格风格
+ (void)tableviewAppStyle
{
    [[UITableView appearance] setBackgroundColor:[KNAppColor tableViewBgColor]];
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

///状态栏风格
+ (void)tableViewCellAppStyle
{
    [[UITableViewCell appearance] setBackgroundColor:[KNAppColor tableViewCellBgColor]];
}

///textField风格
+ (void)textFieldAppStyle
{
    UITextField *appearance = [UITextField appearance];
    [appearance setBackgroundColor:[UIColor clearColor]];
    [appearance setFont:[KNAppFont textFieldFont]];
    [appearance setTextColor:[KNAppColor textFieldTextColor]];
    [appearance setEnablesReturnKeyAutomatically:YES];
    [appearance setClearButtonMode:UITextFieldViewModeWhileEditing];
    [appearance setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [appearance setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [appearance setTintColor:[KNAppColor textFieldTintColor]];
    
    UIImage *bgImage = [UIImage imageNamed:@"inputfield_ border.png"];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:floorf(bgImage.size.width/2) topCapHeight:floorf(bgImage.size.height/2)];
    [appearance setBackground:bgImage];
}

///UILabel风格
+ (void)labelAppStyle
{
    UILabel *label = [UILabel appearance];
    [label setBackgroundColor:[UIColor clearColor]];
}

///按钮风格
+ (void)buttonAppStyle
{
    UIButton *button = [UIButton appearance];
    [button setBackgroundColor:[UIColor clearColor]];
}

///图片
+ (void)imageViewStyle
{
    UIImageView *imageView = [UIImageView appearance];
    [imageView setBackgroundColor:[KNAppColor pictureDefaultBgColor]];
}

@end
