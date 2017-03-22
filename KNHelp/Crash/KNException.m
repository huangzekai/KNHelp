//
//  KNException.m
//  KNHelper
//
//  Created by kennyHuang on 15-04-22.
//  Copyright (c) 2014年 xtuone. All rights reserved.
//

#import "KNException.h"
#import <UIKit/UIKit.h>
#import <libkern/OSAtomic.h>
#import <sys/signal.h>
#import <execinfo.h>
#import <objc/runtime.h>



@interface NSDate (Exception)

///将日期按钮格式的字符串输出
- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

@end

@implementation NSDate (Exception)

///将日期按指定的格式转为字符串
- (NSString *)stringWithDateFormat:(NSString *)dateFormat
{
    NSString *result = nil;
    @autoreleasepool
    {
        if(dateFormat == nil)
        {
            result = self.description;
        }
        else
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = dateFormat;
            result = [formatter stringFromDate:self];;
        }
    }
    return result;
}

@end




#pragma mark - 异常捕捉类

@interface KNException ()
@property (nonatomic, strong) NSArray *callStackSymbols;
@end

//日志保存目录
static NSString *LOG_Directory = nil;

@implementation NSMutableData (Added)

- (void)appendString:(NSString *)string
{
    if(string)
    {
        [self appendBytes:string.UTF8String length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    }
}

@end

void BMWriteLog(NSData *data, NSString *file)
{
    @try
    {
        if(!LOG_Directory)
        {
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
            LOG_Directory = [path stringByAppendingPathComponent:@"debug_log"];
            
            if(![[NSFileManager defaultManager]fileExistsAtPath:LOG_Directory])
            {
                [[NSFileManager defaultManager]createDirectoryAtPath:LOG_Directory
                                         withIntermediateDirectories:NO
                                                          attributes:nil
                                                               error:nil];
            }
        }
        
        NSString *logPath = [LOG_Directory stringByAppendingPathComponent:file];
        
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:logPath];
        
        if(handle)
        {
            [handle seekToEndOfFile];
            [handle writeData:data];
        }
        else
        {
            [data writeToFile:logPath atomically:YES];
        }
        
        [handle closeFile];
    }
    @catch (NSException *exception)
    {
    }
    
}

void BMCacthExection(NSException *exception, BOOL block)
{
    @autoreleasepool
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:5];
        //添加异常参数
        if(exception.callStackSymbols.count > 0)
        {
            dict[@"symbols"] = exception.callStackSymbols.description;
        }
        
        if(exception.name != nil)
        {
            dict[@"name"] = exception.name;
        }
        
        if(exception.reason != nil)
        {
            dict[@"reason"] = exception.reason;
        }
        
        if(exception.userInfo.count > 0)
        {
            dict[@"userinfo"] = exception.userInfo.description;
        }

        NSMutableString *classNames = [NSMutableString string];
        
        /**
         *  注：这里主要是大概获取用户在哪个页面操作崩溃，起到寻找异常辅助作用，异常不一定发生在以下的类中
         */
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        if(tab != nil)
        {
            [classNames appendString:NSStringFromClass(tab.class)];
            UINavigationController *nav = nil;
            if([tab isKindOfClass:[UITabBarController class]])
            {
                nav = (UINavigationController *)tab.selectedViewController;
                [classNames appendFormat:@",%@", NSStringFromClass(nav.class)];
            }
            else
            {
                nav = (UINavigationController *)tab;
            }
            
            if([nav isKindOfClass:[UINavigationController class]])
            {
                for(UIViewController *controller in nav.viewControllers)
                {
                    [classNames appendFormat:@",%@", NSStringFromClass(controller.class)];
                }
            }
            dict[@"classname"] = classNames;
        }
//        dict[@"-----path"] =  [BMUtils getCurrentUsrPath];

        //获取当前时间
        NSDate *date = [NSDate date];
        //日志文件名
        NSString *logPath = [NSString stringWithFormat:@"Bemetoy%@.log", [date stringWithDateFormat:@" yyyy年-MM月-dd日 HH:mm:ss"]];
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        BMWriteLog(data, logPath);
    }
}

void BMUncaughtExceptionHandler(NSException *exception)
{
    @autoreleasepool
    {
        BMCacthExection(exception, YES);
        NSSetUncaughtExceptionHandler(NULL);
        signal(SIGABRT, NULL);
        signal(SIGILL , NULL);
        signal(SIGSEGV, NULL);
        signal(SIGFPE , NULL);
        signal(SIGBUS , NULL);
        signal(SIGPIPE, NULL);
    }
}

void BMSignalHandler(int signal)
{
    @autoreleasepool
    {
        int  maxLines              = 20;
        void  *backstack[maxLines];
        int   frames               = backtrace(backstack, maxLines);
        char **infos               = backtrace_symbols(backstack, frames);
        NSMutableArray  *backtrace = [NSMutableArray arrayWithCapacity:frames];
        for (NSInteger i = 2; i < frames; i++)
        {
            if(infos[i] != NULL)
            {
                backtrace[i] = [NSString stringWithUTF8String:*infos[i]];
            }
        }
        free(infos);
        KNException *exception = [[KNException alloc]initWithName:@"EXC_CTASH(SIGABRT)"
                                                           reason:[NSString stringWithFormat:@"signal value %d",signal]
                                                         userInfo:nil];
        exception.callStackSymbols = backtrace;
        BMUncaughtExceptionHandler(exception);
    }
}

@implementation KNException
@synthesize callStackSymbols = _callStackSymbols;

+ (void)installUncaughtException
{
    //安装异常捕捉器
    NSSetUncaughtExceptionHandler(&BMUncaughtExceptionHandler);
    signal(SIGABRT,  BMSignalHandler);
    signal(SIGILL ,  BMSignalHandler);
    signal(SIGSEGV,  BMSignalHandler);
    signal(SIGFPE,   BMSignalHandler);
    signal(SIGBUS,   BMSignalHandler);
    signal(SIGPIPE,  BMSignalHandler);
}

+ (void)uninstallUncaughtException
{
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL , SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE , SIG_DFL);
    signal(SIGBUS , SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}
@end
