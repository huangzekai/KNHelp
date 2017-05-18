//
//  KNAppMain.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNAppMain : UIResponder
///根视图
@property(strong,nonatomic) UIWindow *window;

+ (KNAppMain *)shareInstance;
///获取根视图
- (UIViewController *)rootViewController;
///设置根视图
- (void)setRootViewController:(UIViewController *)controller;

- (void)onAppLanuch;
- (void)onAppTerminate;
- (void)onAppEnterBackground;
- (void)onAppEnterForeground;

@end

@interface KNAppMain (KNAbstract)

- (void)willMakeKeyAndVisible;

- (void)display;

@end
