//
//  KNSystemPath.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNSystemPath : NSObject

+ (NSString *)GetLibraryCachePath;
+ (NSString *)GetDocPath;

+ (NSString *)GetTmpPath;

+ (NSString *)GetRandomPathOfTrash;
+ (NSString *)GetRootPathOfTrash;

+ (NSString *)HashUserNameForPath:(NSString *)userName;

@end
