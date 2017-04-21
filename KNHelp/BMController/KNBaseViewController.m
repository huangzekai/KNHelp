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
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkChangedNotification:) name:kRealReachabilityChangedNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(applicationEnterbackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    
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

- (void)applicationEnterbackground:(NSNotification *)notification
{
    DDLogInfo(@"\n----------Application did enter background----------\n");
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    DDLogInfo(@"\n----------Application did become active----------\n");
}

#pragma mark - 网络变化监控

- (void)networkChangedNotification:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    DDLogInfo(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
}

@end
