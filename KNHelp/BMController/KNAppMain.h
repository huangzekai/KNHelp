//
//  KNAppMain.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNLoginInfoManager.h"

@interface KNAppMain : UIResponder
///根视图
@property(strong,nonatomic) UIWindow *window;
///登录信息管理器
@property(strong,nonatomic) id<KNLoginManagerDelegate> loginManager;
///获取根视图
- (UIViewController *)rootViewController;
///设置根视图
- (void)setRootViewController:(UIViewController *)controller;

//文件管理
//- (DYFileHandler *)fileHandler;
//
////弹出层
//- (DYDialog *)dialog;
//关闭弹出层
- (void)closeDialog;

//登录
- (void)login:(id)info;

//退出
- (void)logout;

+ (KNAppMain *)shareInstance;

+ (UIViewController *)modalViewController;

+ (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated;

+ (void)dismissModalViewControllerAnimated:(BOOL)animated;
@end

@interface KNAppMain (KNAbstract)

- (void)willMakeKeyAndVisible;

- (void)display;

@end
