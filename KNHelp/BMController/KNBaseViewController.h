//
//  KNBaseViewController.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNHelp.h"

@interface KNBaseViewController : UIViewController

///网络状态变化
- (void)networkChangedNotification:(NSNotification *)notification;

- (ReachabilityStatus)currentNetworkStatus;

- (BOOL)isReachability;

@end
