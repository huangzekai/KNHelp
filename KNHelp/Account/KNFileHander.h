//
//  KNFileHander.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/24.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNFileHander : NSObject

#pragma mark - 属性
//个人目录名
@property (strong,nonatomic) NSString *myDocumentsName;

#pragma mark - 目录路径
//个人目录
- (NSString *)myDocuments;

//上传目录
- (NSString *)sendTo;

//浏览记录目录
- (NSString *)recent;

//个人设置目录
- (NSString *)localSetting;
@end
