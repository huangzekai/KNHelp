//
//  KNAppStyle.m
//  KNHelp
//
//  Created by kennyhuang on 15/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "KNAppStyle.h"
#import "KNAppColor.h"

@implementation UIButton (AppStyle)

- (void)appStyle
{
    [self setTitleColor:[KNAppColor buttonNormalColor] forState:UIControlStateNormal];
    [self setTitleColor:[KNAppColor buttonHighlightColor] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

@end

@implementation UILabel (AppStyle)

- (void)appStyle
{
    self.numberOfLines = 0;
    self.textColor = [KNAppColor labelTextColor];
    self.font = [UIFont systemFontOfSize:14];
}

@end

@implementation UITableView (AppStyle)

- (void)appStyle
{
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
