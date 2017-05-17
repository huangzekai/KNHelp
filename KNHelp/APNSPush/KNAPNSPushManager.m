//
//  KNAPNSPushManager.m
//  KNHelp
//
//  Created by kennykhuang on 10/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "KNAPNSPushManager.h"
#import <UIKit/UIKit.h>

@implementation KNAPNSPushManager

+ (void)registerRemoteNotification {
    UIRemoteNotificationType remoteType = (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert);
    UIApplication *application = [UIApplication sharedApplication];
    if (([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)) {
        UIUserNotificationType userType = (UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert);
        UIUserNotificationSettings *userSetting = [UIUserNotificationSettings settingsForTypes:userType categories:nil];
        
        [application registerForRemoteNotifications];
        [application registerUserNotificationSettings:userSetting];
        
    } else {
        [application registerForRemoteNotificationTypes:remoteType];
    }
}

///注销远程推送
+ (void)unRegisterApnsNotification
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

///清除远程推送通知横幅
- (void)clearRemoteNotificationBander
{
    NSInteger badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
}

///上传badgenumber给服务器
+ (void)updateAppIconBadgeNumberToService
{
    
}

///提交令牌给服务器
+ (void)uploadDeviceTokenToServer:(NSData *)token
{
    if (token)
    {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"appDeviceToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
//    [BMApnsMsgManager updateDeviceToken];
}

///更新设备令牌给服务器
+ (void)updateDeviceToken
{
    NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"appDeviceToken"];
    if (deviceToken)
    {
        NSString *deviceTokenStr = [NSString stringWithFormat:@"%@", deviceToken];
        //移除<>
        deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
        deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@">" withString:@""];
        //移除空格
        deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        ///TODO 提交设备令牌给服务器
        //[GET_SERVICE(BMApnsService) uploadDeviceToken:deviceTokenStr];
    }
}

@end
