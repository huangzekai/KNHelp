//
//  KNBaseTableViewController.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNBaseTableViewController.h"
#import "KNHelp.h"

@interface KNBaseTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, assign) UITableViewStyle style;
@end

@implementation KNBaseTableViewController

- (void)dealloc
{
    _tableView = nil;
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self)
    {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:self.style];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [KNAppColor appGrayBgColor];
    _tableView.separatorColor = [KNAppColor defaultLineColor];
    _tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
