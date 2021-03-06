//
//  UIView+Common.m
//  KNHelp
//
//  Created by KennyHuang on 11/5/17.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#import "UIView+Common.h"
#import "NSMutableObject+SafeInsert.h"

@implementation UIView (Common)

@dynamic top;
@dynamic bottom;
@dynamic left;
@dynamic right;
@dynamic centerX;
@dynamic centerY;
@dynamic width;
@dynamic height;
@dynamic orign;
@dynamic size;

#pragma mark - Position

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)settop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setright:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setbottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setleft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setwidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setheight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setorigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setsize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setcenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setcenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)autoresizingWithHorizontalCenter {
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (void)autoresizingWithVerticalCenter {
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)autoresizingWithStrechFullSize {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *subview = self.subviews.lastObject;
        [subview removeFromSuperview];
    }
}

-(void) removeSubViewWithTag : (UInt32) uiTag {
    UIView * subView = [self viewWithTag:uiTag];
    while( subView ){
        [subView removeFromSuperview];
        subView = [self viewWithTag:uiTag];
    }
}

-(void) removeSubViewWithClass : (Class) oClass {
    for( UIView * subView in self.subviews ){
        if( [subView isKindOfClass:oClass] ){
            [subView removeFromSuperview] ;
        }
    }
}

-(UIView*) viewWithClass : (Class) oClass {
    for( UIView * subView in self.subviews ){
        if( [subView isKindOfClass:oClass] ){
            return subView ;
        }else
        {
            UIView * target = [ subView viewWithClass:oClass ] ;
            if( target )
            {
                return target ;
            }
        }
    }
    return nil ;
}
-(void) subviewsWithClass : (Class) oClass insertIntoArray:(NSMutableArray*)subviewArray
{
    for( UIView * subView in self.subviews )
    {
        if( [subView isKindOfClass:oClass] )
        {
            [subviewArray safeAddObject:subView] ;
        }
        [subView subviewsWithClass:oClass insertIntoArray:subviewArray] ;
    }
    return ;
}

-(NSArray*) subviewsWithClass : (Class) oClass
{
    NSMutableArray * subviewArray = [[NSMutableArray alloc] init] ;
    [self subviewsWithClass:oClass insertIntoArray:subviewArray] ;
    return subviewArray;
}

-(void) removeAllGestureRecognizer
{
    if( ![self respondsToSelector:@selector(gestureRecognizers)] )
        return ;
    
    for( UIGestureRecognizer * gestureRecognizer in self.gestureRecognizers )
    {
        [self removeGestureRecognizer:gestureRecognizer] ;
    }
}

- (UIViewController *)findViewController {
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end
