//
//  KNLongLink.h
//  
//  长链
//  Created by kennyhuang on 16/5/18.
//  Copyright © 2016年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EKNLongLinkState)
{
    //闲置
    EKNConnectIdle = 0,
    ///连接中
    EKNConnecting = 1,
    ///已连接
    EKNConnected = 2,
    ///断开中
    EKNDisConnecting = 3,
    ///已断开
    EKNDisConnected = 4,
    ///连接失败
    EKNConnectFailed = 5,
};

typedef NS_ENUM(NSUInteger, EKNLongLinkSocketUserData)
{
    //用户断开
    EKNSocketOfflineByUser = 0,
    //wifi断开
    EKNSocketOfflineByWifiCut = 1,
    //服务器掉线
    EKNSocketOfflineByServer = 2,
};



@class KNLongLink;
@protocol KNLongLinkDelegate <NSObject>
///长链状态改变
- (void)longLink:(KNLongLink *)link changeConnectState:(EKNLongLinkState)state;
///长链报错
- (void)longLink:(KNLongLink *)link reportErrorWithType:(int)type errorCode:(int)code  seq:(unsigned int)seq;
///长链接收到数据
- (void)longLink:(NSError*)error responseData:(NSData*)bodyData commonId:(int)cmdid;
@end

@interface KNLongLink : NSObject
@property (nonatomic, copy) NSString *host;
@property (nonatomic, readonly) NSUInteger port;
@property (nonatomic, assign) EKNLongLinkState state;
@property (nonatomic, assign) NSTimeInterval timeOut;
@property (nonatomic, weak) id<KNLongLinkDelegate> delegate;

- (instancetype)initWithHost:(NSString *)host andPort:(NSUInteger)port;
- (BOOL)isSyncOK;
- (BOOL)connect;
///发送消息
- (void)sendMessage:(NSData *)data;

-(void)cutOffSocket;
@end
