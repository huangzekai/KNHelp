//
//  KNLoginInfo.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNLoginInfoManager.h"
#import "NSString+KN.h"
#import <sys/xattr.h>

//登录信息保存路径
#define kLoginInfoFile @"syslogin".absolutePathComponent

@implementation KNLoginInfoManager
/*
//初始化
- (id)init{
    self = [super init];
    if(self){
        NSData *data = [NSData dataWithContentsOfFile:kLoginInfoFile];
        if(data.length > 0){
            //解密
            data = [self encrypt:data.bytes length:data.length];
            
            NSString *error;
            NSPropertyListFormat format;
            
            self.dataSource = [NSPropertyListSerialization propertyListFromData:data
                                                               mutabilityOption:NSPropertyListImmutable
                                                                         format:&format
                                                               errorDescription:&error];
        }
    }
    return self;
}
//加密
- (NSData *)encrypt:(const char *)sources length:(NSUInteger)length{
    //加密密钥
    const char keys[] = {0x2f, 0x4a, 0x81, 0x11, 0x56, 0x7c, 0x95, 0xaf, 0xeb};
    //密钥长度
    NSInteger keyLength = sizeof(keys) / sizeof(char);
    //密码数组
    char bytes[length];
    for(NSInteger i = 0 , k = 0; i < length; i++ , k = (k + 1) % keyLength ){
        bytes[i] = sources[i] ^ keys[k];
    }
    return [NSData dataWithBytes:bytes length:length];
}
//是否已经登录
- (BOOL)isLogin{
    return self.token != nil && self.userId > 0;
}
//登出
- (void)logout{
    self.dataSource = nil;
    //删除文件
    NSFileManager *manage = [NSFileManager defaultManager];
    
    NSString *file = kLoginInfoFile;
    
    //判断是否存在文件
    if([manage fileExistsAtPath:file]){
        //删除文件
        [manage removeItemAtPath:file error:nil];
    }
}
//登录
- (void)login:(id)info{
    if(![self.dataSource isEqualToDictionary:info]){
        self.dataSource = info;
        [self save];
    }
}
//保存登录信息
- (void)save{
    if(self.dataSource.count > 0){
        NSString *error;
        NSData *data = [NSPropertyListSerialization dataFromPropertyList:self.dataSource
                                                                  format:NSPropertyListBinaryFormat_v1_0
                                                        errorDescription:&error];
        if(data){
            //加密登录信息
            [[self encrypt:data.bytes length:data.length]writeToFile:kLoginInfoFile atomically:YES];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:kLoginInfoFile]){
                //登录信息,避免被备份到icloud中
                u_int8_t b = 1;
                setxattr(kLoginInfoFile.fileSystemRepresentation, "com.apple.MobileBackup", &b, 1, 0, 0);
            }
        }
    }
}*/
@end

