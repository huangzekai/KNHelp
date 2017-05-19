//
//  KNShareManager.m
//  
//  第三方分享管理类
//  Created by kennyhuang on 16/1/7.
//  Copyright © 2016年 KN. All rights reserved.
//

#import "KNShareManager.h"
/*
#import "KNNotificationCenter.h"
#import "SDWebImageManager.h"
#import "UIImageExtend.h"
#import "KNDialogView.h"

#define kMaxThuKNImageSize (32 * 1024 * 1024)

///微信分享AppId
NSString *const wechatAppId = @"wx85c30bd14cb5051c";

@implementation KNShareManager

+ (void)downThumImageWithUrl:(NSString *)url
{
    if (url.length <= 0)
    {
        DDLogError(@"share url length is 0");
        return;
    }
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *bgUrl = [NSURL URLWithString:url];
    [manager downloadImageWithURL:bgUrl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        DDLogInfo(@"download share image finish:%d, error:%@", finished, [error localizedDescription]);
    }];
}

+ (NSData *)obtainShareImageWithUrl:(NSString *)url
{
    UIImage *defaultImage = [UIImage imageNamed:@"defaultShareImage.png"];
    NSData *data = UIImageJPEGRepresentation(defaultImage, 0.5);
    if (url.length <= 0)
    {
        DDLogError(@"share image url is empty");
        return data;
    }
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    //Fuck！尺寸太大分享不成功，不会报任何错误。
    cachedImage = [cachedImage resizeToMaxWidth:80 andMaxHeight:80];
    
    if (!cachedImage)
    {
        return data;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(cachedImage, 1.0);
    ///限制最大32K
    while ([imageData length] > kMaxThuKNImageSize)
    {
        UIImage *image = [UIImage imageWithData:imageData];
        imageData =  UIImageJPEGRepresentation(image, 0.8);
        DDLogInfo(@"after compress share thumb image size is :%ld", (long)[imageData length]);
    }
    
    return imageData;
}

///注册第三方分享,所有第三方分享注册放这里
+ (void)registerThirdPartyShare
{
    //注册微信分享
    [KNShareManager registerWeChatShare];
}

#pragma mark - 微信分享

+ (void)registerWeChatShare
{
    [WXApi registerApp:wechatAppId];
}

///分享
+ (void)socailShareWithData:(KNSocialShareData *)data scene:(enum WXScene)scene
{
    if (!data) {
        return;
    }
    kShareType type = [data.shareType integerValue];
    
    switch (type)
    {
        case kShareTypeLink:
        {
            [KNShareManager sendLinkMsgToWeChatWithData:data scene:scene];
            break;
        }
        case kShareTypeMusic:
        {
            [KNShareManager sendMusicMsgToWeChatWithData:data scene:scene];
            break;
        }
            
        default:
            break;
    }
}

///是否支持微信分享，有两种情况不支持：1、未安装微信客户端。2、安装了微信客户端，但不支持当前版本的API
+ (BOOL)isSupportWXShare
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        DDLogInfo(@"client is support share WeChat message");
        return YES;
    }
    NSLog(@"Client is install WX:%d, is support current Api:%d", [WXApi isWXAppInstalled], [WXApi isWXAppSupportApi]);
    return NO;
}

+ (NSData *)obtainImageDataWithBase64EncodeString:(NSString *)imageStr
{
    if (!imageStr || [imageStr isKindOfClass:[NSNull class]])
    {
        DDLogError(@"share image data is null");
        UIImage *defaultImage = [UIImage imageNamed:@"defaultShareImage.png"];
        NSData *data = UIImageJPEGRepresentation(defaultImage, 0.5);;
        return data;
    }
    NSData *decodedImageData  = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    DDLogInfo(@"H5 Share thumb image data size :%ld", (long)[decodedImageData length]);
    ///限制最大32K
    while ([decodedImageData length] > kMaxThuKNImageSize)
    {
        UIImage *image = [UIImage imageWithData:decodedImageData];
        if (image.size.width > 120 || image.size.height > 120)
        {
            //Fuck！尺寸太大分享不成功，不会报任何错误。
            image = [image resizeToMaxWidth:80 andMaxHeight:80];
        }
        decodedImageData =  UIImageJPEGRepresentation(image, 0.8);
        DDLogInfo(@"after compress share thumb image size is :%ld", (long)[decodedImageData length]);
    }
    
    return decodedImageData;
}

///发送link消息,标题、内容、网页url、场景值、缩略图5个参数
///标题、描述、图片允许为空，可以正常分享，但webPageUrl不能为空，为空无法分享
+ (BOOL)sendLinkMsgToWeChatWithData:(KNSocialShareData *)data scene:(enum WXScene)scene
{
    DDLogInfo(@"send link msg with title:%@, desc:%@, webUrl:%@, scene:%ld", data.title, data.desc, data.webUrl, (long)scene);
    
    if (![KNShareManager isSupportWXShare])
    {
        [KNDialogView showInView:[UIApplication sharedApplication].keyWindow withStyle:kKNDialogViewStyleAutoDismissText message:NSLocalizedString(@"Install_Newest_WX_Client", nil)];
        return NO;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = data.title;
    message.description = data.desc;
    if (data.imgUrl.length > 0)
    {
        NSData *decodedImageData  = [KNShareManager obtainShareImageWithUrl:data.imgUrl];
        [message setThumbData:decodedImageData];
    }
    else
    {
        NSData *decodedImageData  = [KNShareManager obtainImageDataWithBase64EncodeString:data.imageData];
        [message setThumbData:decodedImageData];
    }
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = data.webUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    BOOL result = [WXApi sendReq:req];
    DDLogInfo(@"send link msg to WeChat result:%ld", (long)result);
    
    return result;
}

///发送音乐消息,6个参数：标题、内容、播放的url、网页Url、缩略图、场景值
///标题、描述、图片允许为空，可以正常分享，但webPageUrl、dataUrl不能为空，为空无法分享
+ (BOOL)sendMusicMsgToWeChatWithData:(KNSocialShareData *)data scene:(enum WXScene)scene
{
    DDLogInfo(@"send music msg to WeChat with title:%@, desc:%@, webUrl:%@, musicDataUrl:%@, scene:%ld", data.title, data.desc, data.webUrl, data.musicUrl, (long)scene);
    
    if (![KNShareManager isSupportWXShare])
    {
        [KNDialogView showInView:[UIApplication sharedApplication].keyWindow withStyle:kKNDialogViewStyleAutoDismissText message:NSLocalizedString(@"Install_Newest_WX_Client", nil)];
        return NO;
    }
    
    //防止H5传NSNull
    if (!data.title || [data.title isKindOfClass:[NSNull class]])
    {
        data.title = @"";
    }
    
    if (!data.desc || [data.desc isKindOfClass:[NSNull class]])
    {
        data.desc = @"";
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = data.title;
    message.description = data.desc;
    if (data.imgUrl.length > 0)
    {
        NSData *decodedImageData  = [KNShareManager obtainShareImageWithUrl:data.imgUrl];
        [message setThumbData:decodedImageData];
    }
    else
    {
        NSData *decodedImageData  = [KNShareManager obtainImageDataWithBase64EncodeString:data.imageData];
        [message setThumbData:decodedImageData];
    }
    
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = data.webUrl;
    ext.musicDataUrl = data.musicUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    BOOL result = [WXApi sendReq:req];
    DDLogInfo(@"send music msg to WeChat result:%ld", (long)result);
    
    return result;
}

///处理微信返回结果
+ (void)handleWXresponse:(BaseResp *)response
{
    if ([response isKindOfClass:[SendMessageToWXResp class]])
    {
        DDLogInfo(@"handle WX response with errorCode:%@", [@(response.errCode) stringValue]);
        NSString *message = @"";
        switch (response.errCode)
        {
                //成功
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNWeChatShareResponseNotification object:nil userInfo:nil];
                message = NSLocalizedString(@"Share_Success", nil);
                break;
            }
                //普通错误类型
            case WXErrCodeCommon:
            {
                message = [NSString stringWithFormat:@"错误码:%ld", (long)WXErrCodeCommon];
                break;
            }
                //用户点击取消并返回
            case WXErrCodeUserCancel:
            {
                break;
            }
                //发送失败
            case WXErrCodeSentFail:
            {
                message = NSLocalizedString(@"Share_Send_Failed", nil);
                break;
            }
                //授权失败
            case WXErrCodeAuthDeny:
            {
                message = NSLocalizedString(@"Share_Auth_Failed", nil);
                break;
            }
                //微信不支持
            case WXErrCodeUnsupport:
            {
                message = NSLocalizedString(@"Share_WX_UnSport", nil);
                break;
            }
            default:
                break;
        }
        if (message.length > 0)
        {
            [KNDialogView showInView:[UIApplication sharedApplication].keyWindow withStyle:kKNDialogViewStyleAutoDismissText message:message];
        }
    }
}

@end


#pragma mark - 分享数据

///分享数据
@implementation KNSocialShareData

@end
 
 */
