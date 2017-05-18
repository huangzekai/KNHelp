//
//  KNLoginInfo.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KNLoginManagerDelegate <NSObject>

@required
//令牌
- (NSString *)token;
//登录会员id
- (NSUInteger)userId;
//字符串的形式获取id
- (NSString *)userIdString;
//是否已经登录
- (BOOL)isLogin;
//登出
- (void)logout;
//登录
- (void)login:(id)info;
//保存登录信息
- (void)save;
@end

@interface KNLoginManager : NSObject
@property (nonatomic, weak) id<KNLoginManagerDelegate> delegate;
@property (nonatomic, readonly) BOOL hasLogined;
@end

//继承类必须实现接口
@interface KNLoginManager(KN)// <KNLoginInfoDelegate>
@end
