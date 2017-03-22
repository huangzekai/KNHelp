//
//  KNBaseViewController.m
//  KNHelp
//
//  Created by kennyhuang on 2016/10/21.
//  Copyright © 2016年 KennyHuang. All rights reserved.
//

#import "KNBaseViewController.h"
#import "KNAppColor.h"

@interface KNBaseViewController ()

@end

@implementation KNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [KNAppColor viewControllerBackgroundColor];
    
}

-(void)setLeftBarButtonItemWithButton:(UIButton*)button
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)setRightBarButtonItemWithButton:(UIButton*)button;
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)setLeftBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(MAXFLOAT,27) lineBreakMode:UILineBreakModeWordWrap].width+7;
    width = width<42.0?42:width;
    
    UIImage* normalBg = [UIImage imageNamed:@"banner_btn_normal.png"];
    normalBg = [normalBg stretchableImageWithLeftCapWidth:7 topCapHeight:0];
    UIImage* highlightBg = [UIImage imageNamed:@"banner_btn_hightlighted.png"];
    highlightBg = [highlightBg stretchableImageWithLeftCapWidth:7 topCapHeight:0];
    
    UIButton* left = [[UIButton alloc] initWithFrame:CGRectMake(0,0,width,27)];
    [left setBackgroundImage:normalBg forState:UIControlStateNormal];
    [left setBackgroundImage:highlightBg forState:UIControlStateHighlighted];
    [left setTitle:title forState:UIControlStateNormal];
    left.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [left addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftBarButtonItemWithButton:left];
}

-(void)setRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(MAXFLOAT,27) lineBreakMode:UILineBreakModeWordWrap].width+7;
    width = width<42.0?42:width;
    
    UIImage* normalBg = [UIImage imageNamed:@"banner_btn_normal.png"];
    normalBg = [normalBg stretchableImageWithLeftCapWidth:7 topCapHeight:0];
    UIImage* highlightBg = [UIImage imageNamed:@"banner_btn_hightlighted.png"];
    highlightBg = [highlightBg stretchableImageWithLeftCapWidth:7 topCapHeight:0];
    
    UIButton* right = [[UIButton alloc] initWithFrame:CGRectMake(0,0,width,27)];
    [right setBackgroundImage:normalBg forState:UIControlStateNormal];
    [right setBackgroundImage:highlightBg forState:UIControlStateHighlighted];
    [right setTitle:title forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [right addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarButtonItemWithButton:right];
}

-(void)setLeftIconButtonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage target:(id)target action:(SEL)action;
{
    UIButton* back_button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,42,27)];
    [back_button setImage:image forState:UIControlStateNormal];
    [back_button setImage:highlightImage forState:UIControlStateHighlighted];
    [back_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    back_button.showsTouchWhenHighlighted = YES;
    back_button.contentMode = UIViewContentModeCenter;
    
    [self setLeftBarButtonItemWithButton:back_button];
}

-(void)setRightIconButtonWithImage:(UIImage*)image highlightImage:(UIImage*)highlightImage target:(id)target action:(SEL)action;
{
    UIButton* back_button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,42,27)];
    [back_button setImage:image forState:UIControlStateNormal];
    [back_button setImage:highlightImage forState:UIControlStateHighlighted];
    [back_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    back_button.showsTouchWhenHighlighted = YES;
    back_button.contentMode = UIViewContentModeCenter;
    
    [self setRightBarButtonItemWithButton:back_button];
}

-(void)setBackBarButton
{
    UIButton* back_button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,42,27)];
    [back_button setImage:[UIImage imageNamed:@"header_back.png"] forState:UIControlStateNormal];
    [back_button setImage:[UIImage imageNamed:@"header_back.png"] forState:UIControlStateHighlighted];
    [back_button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    back_button.showsTouchWhenHighlighted = YES;
    back_button.contentMode = UIViewContentModeCenter;
    
    [self setLeftBarButtonItemWithButton:back_button];
}

#pragma mark - Dialog Function
-(void)showAlertInView:(UIView*)view title:(NSString*)title
{
//    [self.dialog showInView:view title:title style:DYDialogStyleBoxWarning];
}
-(void)showOkInView:(UIView*)view title:(NSString*)title
{
//    [self.dialog showInView:view title:title style:DYDialogStyleBoxOK];
}
-(void)showLoadingInView:(UIView*)view title:(NSString*)title
{
//    [self.dialog showInView:view title:title style:DYDialogStyleLoading];
}

@end
