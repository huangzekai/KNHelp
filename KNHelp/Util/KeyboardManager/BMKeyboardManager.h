//
//  BMKeyboardManager.h
//  BMComLibrary
//
//  Created by zhaoYuan on 16/8/8.
//  Copyright © 2016年 kennyhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    BOOL fromVisible; //< Keyboard visible before transition.
    BOOL toVisible;   //< Keyboard visible after transition.
    CGRect fromFrame; //< Keyboard frame before transition.
    CGRect toFrame;   //< Keyboard frame after transition.
    NSTimeInterval animationDuration;       //< Keyboard transition animation duration.
    UIViewAnimationCurve animationCurve;    //< Keyboard transition animation curve.
    UIViewAnimationOptions animationOption; //< Keybaord transition animation option.
} BMKeyboardTransition;

@protocol BMKeyboardObserver <NSObject>

@optional

- (void)keyboardChangedWithTransition:(BMKeyboardTransition)transition;

@end


@interface BMKeyboardManager : NSObject

+ (instancetype)shareManager;

- (void)addObserver:(id<BMKeyboardObserver>)observer;

- (void)removeObserver:(id<BMKeyboardObserver>)observer;

- (void)removeAllObserver;

@end

