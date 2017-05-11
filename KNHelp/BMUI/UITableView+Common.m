//
//  UITableView+Common.m
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import "UITableView+Common.h"

@implementation UITableView (Common)

+ (UITableView *)obtainPlainTableViewWithFrame:(CGRect)frame delegateSource:(id)obj
{
    return [UITableView obtainTableViewWithFrame:frame style:UITableViewStylePlain delegateSource:obj];
}

+ (UITableView *)obtainGroupTableviewWithFrame:(CGRect)frame delegateSource:(id)obj
{
    return [UITableView obtainTableViewWithFrame:frame style:UITableViewStyleGrouped delegateSource:obj];
}

+ (UITableView *)obtainTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegateSource:(id)obj
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = obj;
    tableView.dataSource = obj;
    
    return tableView;
    
}

@end
