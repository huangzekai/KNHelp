//
//  KNBaseTableViewController.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNBaseViewController.h"

@interface KNBaseTableViewController : KNBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readonly) UITableView *tableView;
- (instancetype)initWithTableViewStyle:(UITableViewStyle)style;
@end
