//
//  NSString+KN.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "NSString+KN.h"

@implementation NSString (KN)
//相对应该根目录的绝对路径
- (NSString *)absolutePath
{
    return self.absolutePathComponent;
}

- (NSString *)absolutePathComponent
{
    return [KNDocumentDirectory() stringByAppendingPathComponent:self];
}

//指定编码格式进行url编码
- (NSString *)stringByURLEncodeUsingEncoding:(CFStringBuiltInEncodings)encoding
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                     kCFAllocatorDefault,
                                                                     //将当前objectC字符串转为CF字符串
                                                                     (__bridge CFStringRef)self,
                                                                     NULL,
                                                                     //被编码的字符
                                                                     CFSTR("!?&+=%# |"),
                                                                     encoding));
}

NSString *const KNDocumentDirectory(void)
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

@end
