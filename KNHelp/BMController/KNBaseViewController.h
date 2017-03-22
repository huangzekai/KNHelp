//
//  KNBaseViewController.h
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNBaseViewController : UIViewController

/*
 * 使用按钮设置左边按钮
 */
-(void)setLeftBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/*
 * 使用按钮设置右边按钮
 */
-(void)setRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/*
 * 使用标题，目标，动作设置左边按钮
 */
-(void)setLeftBarButtonItemWithButton:(UIButton*)button;

/*
 * 使用标题，目标，动作设置右边按钮
 */
-(void)setRightBarButtonItemWithButton:(UIButton*)button;

/*
 * 使用图标，高亮图标，，目标，动作设置左边按钮
 */
-(void)setLeftIconButtonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage target:(id)target action:(SEL)action;

/*
 * 使用图标，高亮图标，目标，动作设置右边按钮
 */
-(void)setRightIconButtonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage target:(id)target action:(SEL)action;

/*
 * 设置返回按钮
 */
-(void)setBackBarButton;

-(void)showAlertInView:(UIView*)view title:(NSString*)title;
-(void)showOkInView:(UIView*)view title:(NSString*)title;
-(void)showLoadingInView:(UIView*)view title:(NSString*)title;

-(void)openAppStoreViewControllerWidthAppleID:(NSString*)appleId;

@end
