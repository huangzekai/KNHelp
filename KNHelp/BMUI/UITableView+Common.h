//
//  UITableView+Common.h
//  KNVideoTest
//
//  Created by kennykhuang on 4/2/17.
//  Copyright © 2017年 kennykhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)

+ (UITableView *)obtainGroupTableviewWithFrame:(CGRect)frame delegateSource:(id)obj;

+ (UITableView *)obtainPlainTableViewWithFrame:(CGRect)frame delegateSource:(id)obj;

@end
