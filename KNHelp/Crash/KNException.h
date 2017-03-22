//
//  KNException.h
//
//  程序闪退之前对异常的信息进行捕获
//  Created by kennyHuang on 15-04-22.
//  Copyright (c) 2014年 xtuone. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KNException : NSException
///在每个应用的AppDetegate的 application:didFinishLaunchingWithOptions:中进行安装调用
+ (void)installUncaughtException;
//删除异常的捕获
+ (void)uninstallUncaughtException;
@end

@interface KNException(BMAbstract)

@end

//捕捉异常
void BMCacthExection(NSException *exception, BOOL block);
