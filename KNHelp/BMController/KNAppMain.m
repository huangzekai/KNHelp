//
//  KNAppMain.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNAppMain.h"

@interface KNAppMain ()

@end

@implementation KNAppMain
@synthesize window = _window;

- (void)setRootViewController:(UIViewController *)controller
{
    @synchronized (self)
    {
        if ([self.rootViewController isEqual:controller])
        {
            return;
        }
        
        if (!self.rootViewController)
        {
            self.window.rootViewController = controller;
        }
        else
        {
            CGRect rect = self.rootViewController.view.frame;
            UIGraphicsBeginImageContext(self.window.bounds.size);
            [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIView *view               = [[UIView alloc]initWithFrame:rect];
            view.layer.contentsGravity = kCAGravityTop;
            view.layer.contentsScale   = image.scale;
            view.layer.masksToBounds   = YES;
            view.layer.contents        = (id)image.CGImage;
            
            __block UIViewController *cacheViewController = self.rootViewController;
            
            self.window.rootViewController = controller;
            
            UIView *modifyView = nil;
            
            rect.origin.y = CGRectGetMaxY(rect);
            
            if([self.loginManager isLogin])
            {
                [controller.view addSubview:view];
                modifyView = view;
            }
            else
            {
                [self.window insertSubview:view belowSubview:controller.view];
                self.rootViewController.view.frame = rect;
                rect.origin.y                     -= CGRectGetHeight(rect);
                modifyView                         = controller.view;
            }
            
            [UIView animateWithDuration:.5
                             animations:^{
                                 modifyView.frame = rect;
                             }
                             completion:^(BOOL finished){
                                 @autoreleasepool
                                 {
                                     [view removeFromSuperview];
                                     //清空视图
                                     if([cacheViewController isViewLoaded])
                                     {
                                         [cacheViewController.view removeFromSuperview];
                                     }
                                     cacheViewController = nil;
                                 }
                             }];
        }
        
    }
}

+ (KNAppMain *)shareInstance
{
    return (KNAppMain *)[UIApplication sharedApplication].delegate;
}

#pragma mark - 应用接口

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc]initWithFrame:rect];
    self.window.backgroundColor = [UIColor blackColor];
    
    [self.window makeKeyAndVisible];
    
    if([self respondsToSelector:@selector(willMakeKeyAndVisible)]){
        [self willMakeKeyAndVisible];
    }
    
    [self display];

    return YES;
}

@end
