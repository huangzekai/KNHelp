//
//  UIView+Common.h
//  KNHelp
//
//  Created by KennyHuang on 11/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

#pragma mark - Position
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint orign;
@property (nonatomic, assign) CGSize size;

- (void)removeAllSubviews;

@end
