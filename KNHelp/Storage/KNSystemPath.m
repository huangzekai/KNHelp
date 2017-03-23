//
//  KNSystemPath.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNSystemPath.h"
#import <sys/xattr.h>
#import "BaseFile.h"
//#import "Utility.h"


#define BM_CACHE_DIR_NAME @"KNPrivate"
#define BM_CACHE_VERSION_DIR_NAME @"1.2"

#define BM_DOCUMENT_DIR_NAME @"Bemetoy"
#define BM_DOCUMENT_VERSION_DIR_NAME @"1.2"

#define TRASH_ROOT_DIR @"trash"

#define PATHUTILITY_SYNCHRONIZED_NAME @"PathUtilityMain"

@implementation KNSystemPath
/*
static NSString* g_libraryCachePath = nil;

+(NSString*) GetLibraryCachePath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cacheRootPath = [PathUtility GetLibraryCacheFixRootPath];
        if (cacheRootPath.length < 1) {
            CommonError(@"GetLibraryCachePath, LibraryCacheFixRootPath is empty!");
            assert(cacheRootPath.length > 0);
            return;
        }
        
        NSString *libCachePath = [cacheRootPath stringByAppendingPathComponent: BM_CACHE_VERSION_DIR_NAME];
        if(![CBaseFile FileExist:libCachePath])
        {
            [CBaseFile CreatePath:libCachePath];
            [PathUtility setDoNotBackupForPath:libCachePath]; // 标记不备份到icloud
        }
        
        g_libraryCachePath = libCachePath;
    });
    
    return g_libraryCachePath;
}

static NSString* g_docPath = nil;

+ (NSString*) GetDocPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docRootPath = [PathUtility GetDocFixRootPath];
        if (docRootPath.length < 1) {
            CommonError(@"GetDocPath, DocFixRootPath is empty!");
            assert(docRootPath.length > 0);
            return;
        }
        
        NSString *docPath = [docRootPath stringByAppendingPathComponent:BM_DOCUMENT_VERSION_DIR_NAME];
        if (![CBaseFile FileExist:docPath]) {
            [CBaseFile CreatePath:docPath];
        }
        
        g_docPath = docPath;
    });
    
    return g_docPath;
}

static NSString* g_libraryCacheFixRootPath = nil;

+(NSString *)GetLibraryCacheFixRootPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *sysLibraryPath = [PathUtility getSysLibraryPath];
        if (sysLibraryPath.length < 1) {
            CommonError(@"GetLibraryCacheFixRootPath, SysLibraryPath is empty!");
            assert(sysLibraryPath.length > 0);
            return;
        }
        
        NSString *cacheRootPath = [sysLibraryPath stringByAppendingPathComponent:BM_CACHE_DIR_NAME];
        if (![CBaseFile FileExist:cacheRootPath]) {
            [CBaseFile CreatePath:cacheRootPath];
        }
        
        g_libraryCacheFixRootPath = cacheRootPath;
    });
    
    return g_libraryCacheFixRootPath;
}

static NSString *g_docFixRootPath = nil;

+ (NSString *)GetDocFixRootPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *sysDocPath = [PathUtility getSysDocumentPath];
        if (sysDocPath.length < 1) {
            CommonError(@"GetDocFixRootPath, SysDocumentPath is empty!");
            assert(sysDocPath.length > 0);
            return;
        }
        
        NSString *docRootPath = [sysDocPath stringByAppendingPathComponent:BM_DOCUMENT_DIR_NAME];
        if (![CBaseFile FileExist:docRootPath]) {
            [CBaseFile CreatePath:docRootPath];
        }
        
        g_docFixRootPath = docRootPath;
    });
    return g_docFixRootPath;
}

+ (NSString*) GetTmpPath
{
    NSString* nsTmpPath = [[NSString alloc] initWithString:NSTemporaryDirectory()];
    return nsTmpPath;
}

+ (NSString*) GetRandomPathOfTrash
{
    NSString *curTime = [NSString stringWithFormat:@"%llu", [CUtility GetCurrentTimeInMs]];
    
    unsigned char buf[16];
    md5_digest([curTime UTF8String],
               (unsigned int)[curTime lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
               buf);
    
    char des[33] = {0};
    md5_sig16_to_hex_string((char *)buf, des, 33);
    
    NSString *fileName = [NSString stringWithUTF8String:des];
    
    return [NSString stringWithFormat:@"%@/%@", [PathUtility GetRootPathOfTrash], fileName];
}

+ (NSString*) GetRootPathOfTrash
{
    return [NSString stringWithFormat:@"%@/%@", [PathUtility GetTmpPath], TRASH_ROOT_DIR];
}

+ (NSString *)HashUserNameForPath:(NSString *)userName
{
    unsigned char buf[16];
    md5_digest([userName UTF8String],
               (unsigned int)[userName lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
               buf);
    
    char des[33] = {0};
    md5_sig16_to_hex_string((char *)buf, des, 33);
    
    NSMutableString* hashedString = [[NSMutableString alloc] initWithCString:des
                                                                    encoding:NSUTF8StringEncoding];
    [hashedString insertString:@"/" atIndex:2];
    return [NSString stringWithString:hashedString];
}

#pragma mark - private

+ (NSString *)getSysLibraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if (paths.count < 1) {
        return nil;
    }
    
    return (NSString *)[paths objectAtIndex:0];
}

+ (NSString *)getSysDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    if (paths.count < 1) {
        return nil;
    }
    
    return (NSString *)[paths objectAtIndex:0];
}

+ (BOOL)setDoNotBackupForPath:(NSString *)path
{
    const char* filePath = [path fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}*/

@end
