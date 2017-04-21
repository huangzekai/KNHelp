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

#pragma mark - 通知

- (void)networkChangedNotification:(NSNotification *)notification;

- (void)applicationEnterbackground:(NSNotification *)notification;

- (void)applicationDidBecomeActive:(NSNotification *)notification;

- (ReachabilityStatus)currentNetworkStatus;

- (BOOL)isReachability;

@end
