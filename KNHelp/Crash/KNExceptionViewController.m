//
//  KNExceptionViewController.m
//  DebugKit
//
//  Created by kennyHuang on 15-04-22.
//  Copyright (c) 2015年 kennyHuang. All rights reserved.
//

#import "KNExceptionViewController.h"

@interface KNExceptionViewController ()
//文件
@property (nonatomic, strong) NSArray *files;
@end

@implementation KNExceptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"异常日志";
    
    if(self.path)
    {
        self.files = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:self.path error:nil];
    }
    else
    {
        self.files = nil;
    }
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]init];
    btn.title  = @"关闭";
    btn.target = self;
    btn.action = @selector(close);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)close
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    
    cell.textLabel.text = self.files[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.path)
    {
        return;
    }
    
    NSString *file = self.files[indexPath.row];
    
    if(![file.pathExtension isEqualToString:@"log"])
    {
        return;
    }
    
    NSString *path = [self.path stringByAppendingPathComponent:file];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    //获取日志内容
    UIWebView *webView = [[UIWebView alloc]init];
    [webView loadData:data MIMEType:@"text/plain" textEncodingName:@"utf-8" baseURL:nil];
    
    //加载完成滚动到底部
    NSString *js = @"window.onload = function(){window.scrollBy(0, document.body.offsetHeight)}";
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    UIViewController *viewController = [[UIViewController alloc]init];
    viewController.view  = webView;
    viewController.title = file;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
