//
//  KNBaseViewController.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNBaseViewController.h"

/*基类做以下事情：
 *  1.统一背景颜色
 *  2.网络状态监控
 *  3.
 *
 *
 *
 *
 */

@interface KNBaseViewController ()

@end

@implementation KNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [KNAppColor viewControllerBackgroundColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChangedNotification:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - 公有方法

- (ReachabilityStatus)currentNetworkStatus
{
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    
    return status;
}

- (BOOL)isReachability
{
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    
    return (status != RealStatusNotReachable);
}

#pragma mark - 网络变化监控

- (void)networkChangedNotification:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    DDLogInfo(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
//    if (status == RealStatusNotReachable)
//    {
//        NSLog(@"Network unreachable!");
//        self.netType = NoNetWork;
//        [self.view bringSubviewToFront:self.netAlertView];
//        [UIView animateWithDuration:0.5f animations:^{
//            self.netAlertView.hidden = NO;
//        }];
//        //显示无网提示信息
//        [self showNetError];
//    }
//    
//    if (status == RealStatusViaWiFi)
//    {
//        NSLog(@"Network wifi! Free!");
//        self.netType = WiFi;
//        self.netAlertView.hidden = YES;
//        [self hideNetError];
//    }
//    
//    if (status == RealStatusViaWWAN)
//    {
//        NSLog(@"Network WWAN! In charge!");
//        self.netAlertView.hidden = YES;
//        [self hideNetError];
//    }
//    
//    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
//    
//    if (status == RealStatusViaWWAN)
//    {
//        if (accessType == WWANType2G)
//        {
//            NSLog(@"RealReachabilityStatus2G");
//            self.netType = WWAN2G;
//            self.netAlertView.hidden = YES;
//            [self hideNetError];
//        }
//        else if (accessType == WWANType3G)
//        {
//            NSLog(@"RealReachabilityStatus3G");
//            self.netType = WWAN3G;
//            self.netAlertView.hidden = YES;
//            [self hideNetError];
//        }
//        else if (accessType == WWANType4G)
//        {
//            NSLog(@"RealReachabilityStatus4G");
//            self.netType = WWAN4G;
//            self.netAlertView.hidden = YES;
//            [self hideNetError];
//        }
//        else
//        {
//            NSLog(@"Unknown RealReachability WWAN Status, might be iOS6");
//        }
//    }
}

@end
