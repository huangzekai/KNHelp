//
//  KNDebugViewController.m
//  KNHelp
//
//  Created by kennykhuang on 10/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "KNDebugViewController.h"
#import "KNEnvChangeViewController.h"
#import "KNUserInfoViewController.h"
#import "KNRMCacheViewController.h"
#import "KNDebugLogViewController.h"

typedef NS_ENUM(NSInteger, kDebugType)
{
    kDebugTypeEnvChange = 0,
    kDebugTypeUserInfo = 1,
    kDebugTypeCrash = 2,
    kDebugTypeLog = 3,
    kDebugTypeMenory = 4,
    kDebugTypeCache = 5,
};

@interface KNDebugViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *listItems;
@end

@implementation KNDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.listItems = @[@"环境切换",
                       @"用户信息",
                       @"crash捕捉",
                       @"LOG日志",
                       @"内存监控",
                       @"清除缓存"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - tableview 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.listItems objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case kDebugTypeEnvChange:
            controller = [[KNEnvChangeViewController alloc]init];
            break;
        case kDebugTypeUserInfo:
            controller = [[KNUserInfoViewController alloc]init];
            break;
        case kDebugTypeCrash:
            
            break;
        case kDebugTypeLog:
            controller = [[KNDebugLogViewController alloc]init];
            break;
        case kDebugTypeMenory:
            
            break;
        case kDebugTypeCache:
            controller = [[KNRMCacheViewController alloc]init];
            break;
        default:
            break;
    }
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
