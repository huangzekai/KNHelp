//
//  UIDevice+Common.m
//  KNHelp
//
//  Created by kennykhuang on 17/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "UIDevice+Common.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation UIDevice (Common)

/**
 *  判断手机设备是否开启麦克风、相机权限
 *  @param mediaType 设备类型（AVMediaTypeVideo、AVMediaTypeAudio）
 *  注:(iOS7开始才有"设置-隐私-相机"这一项)
 */
+ (BOOL)isAuthorizedForMediaType:(NSString *)mediaType
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(status != AVAuthorizationStatusAuthorized && status != AVAuthorizationStatusNotDetermined)
    {
        return NO;
    }
    return YES;
}

@end
