//
//  KNAPNSPushManager.h
//  KNHelp
//
//  Created by kennykhuang on 10/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNAPNSPushManager : NSObject

///注册远程推送
+ (void)registerRemoteNotification;

///注销远程推送
+ (void)unRegisterApnsNotification;

///清除远程推送通知横幅
- (void)clearRemoteNotificationBander;

///上传badgenumber给服务器
+ (void)updateAppIconBadgeNumberToService;

///提交令牌给服务器
+ (void)uploadDeviceTokenToServer:(NSData *)token;

@end
