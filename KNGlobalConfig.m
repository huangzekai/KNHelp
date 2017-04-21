//
//  KNGlobalConfig.m
//  KNHelp
//
//  Created by kennykhuang on 2017/4/20.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "KNGlobalConfig.h"
#import<CocoaLumberjack/CocoaLumberjack.h>

@implementation KNGlobalConfig

+ (void)defaultLogConfig
{
#ifdef DEBUG
    //打印到控制台，发送到苹果
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
#else
    //只发送到苹果
    [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif
}

@end
