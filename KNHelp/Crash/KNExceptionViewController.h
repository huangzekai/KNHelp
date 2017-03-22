//
//  KNExceptionViewController.h
//  异常捕捉控制器
//
//  Created by kennyHuang on 15-04-22.
//  Copyright (c) 2015年 kennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNExceptionViewController : UITableViewController

///日志路径,读取此路径下的所有日志文件，在表格中显示出来
@property (nonatomic, strong) NSString *path;
@end
