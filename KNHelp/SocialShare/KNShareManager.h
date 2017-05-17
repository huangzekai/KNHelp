//
//  KNShareManager.h
//  
//  第三方分享管理类
//  Created by kennyhuang on 16/1/7.
//  Copyright © 2016年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNHelp.h"
#import "WeChat/WXApiObject.h"
#import "WeChat/WXApi.h"

///目前主要支持分享到微信朋友圈、微信好友
///以后有关第三方分享的都放在这里

typedef NS_ENUM(NSInteger, kShareType)
{
    //链接类型，(专辑、电台、专题)
    kShareTypeLink = 0,
    //单个歌曲类型
    kShareTypeMusic = 1,
    //视频类型
    kShareTypeMedia = 2,
    //图片类型
    kShareTypePhoto = 3,
};

@class KNSocialShareData;
@interface KNShareManager : NSObject

+ (void)downThumImageWithUrl:(NSString *)url;

///注册第三方分享
+ (void)registerThirdPartyShare;

///分享
+ (void)socailShareWithData:(KNSocialShareData *)data scene:(enum WXScene)scene;

///处理微信返回结果
+ (void)handleWXresponse:(BaseResp *)response;

@end



#pragma mark - 分享数据

///分享数据
@interface KNSocialShareData : JSONModel
///分享类型
@property (nonatomic) NSString *shareType;
///标题
@property (nonatomic, strong) NSString *title;
///描述
@property (nonatomic, strong) NSString *desc;
///音乐链接
@property (nonatomic, strong) NSString *musicUrl;
///webUrl
@property (nonatomic, strong) NSString *webUrl;
///缩略图数据
@property (nonatomic, strong) NSString *imageData;
///缩略图的url
@property (nonatomic, strong) NSString *imgUrl;
///分享成功回调H5函数
@property (nonatomic, strong) NSString *functionName;
@end
