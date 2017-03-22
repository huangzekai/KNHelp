//
//  BMKeyboardManager.m
//  BMComLibrary
//
//  Created by zhaoYuan on 16/8/8.
//  Copyright © 2016年 kennyhuang. All rights reserved.
//

#import "BMKeyboardManager.h"

@interface BMKeyboardManager()
{
    UIInterfaceOrientation _fromOrientation;
    
    BMKeyboardTransition _keyboardDidChangeTransition;
    BMKeyboardTransition _keyboardWillChangeTransition;
}

@property(nonatomic, strong) NSHashTable *observers;

@end

@implementation BMKeyboardManager

+ (instancetype)shareManager
{
    static BMKeyboardManager *shareManger = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManger = [[self alloc] init];
    });
    
    return shareManger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observers = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardFrameDidChangeNotification:)
                                                     name:UIKeyboardDidChangeFrameNotification
                                                   object:nil];
    }
    
    
    return self;
}


- (void)addObserver:(id<BMKeyboardObserver>)observer
{
    if (!observer) {
        return;
    }
    
    [_observers addObject:observer];
}


- (void)removeObserver:(id<BMKeyboardObserver>)observer
{
    if (!observer) {
        return;
    }
    [_observers removeObject:observer];
}


- (void)removeAllObserver
{
    [_observers removeAllObjects];
}

- (void)keyboardFrameWillChangeNotification:(NSNotification *)notif {
    if (![notif.name isEqualToString:UIKeyboardWillChangeFrameNotification]) return;
    NSDictionary *info = notif.userInfo;
    if (!info) return;
    
    NSValue *beforeValue = info[UIKeyboardFrameBeginUserInfoKey];
    NSValue *afterValue = info[UIKeyboardFrameEndUserInfoKey];
    NSNumber *curveNumber = info[UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *durationNumber = info[UIKeyboardAnimationDurationUserInfoKey];
    
    CGRect before = beforeValue.CGRectValue;
    CGRect after = afterValue.CGRectValue;
    UIViewAnimationCurve curve = curveNumber.integerValue;
    NSTimeInterval duration = durationNumber.doubleValue;
    
    if (after.size.width <= 0 && after.size.height <= 0) return;
    
    _keyboardWillChangeTransition.fromFrame = before;
    _keyboardWillChangeTransition.toFrame = after;
    _keyboardWillChangeTransition.animationCurve = curve;
    _keyboardWillChangeTransition.animationDuration = duration;
    
    [self notifyObservers];
}

- (void)keyboardFrameDidChangeNotification:(NSNotification *)notif {
    if (![notif.name isEqualToString:UIKeyboardDidChangeFrameNotification]) return;
    NSDictionary *info = notif.userInfo;
    if (!info) return;
    
    NSValue *beforeValue = info[UIKeyboardFrameBeginUserInfoKey];
    NSValue *afterValue = info[UIKeyboardFrameEndUserInfoKey];
    NSNumber *curveNumber = info[UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *durationNumber = info[UIKeyboardAnimationDurationUserInfoKey];
    
    CGRect before = beforeValue.CGRectValue;
    CGRect after = afterValue.CGRectValue;
    UIViewAnimationCurve curve = curveNumber.integerValue;
    NSTimeInterval duration = durationNumber.doubleValue;
    
    if (after.size.width <= 0 && after.size.height <= 0) return;
    
    _keyboardDidChangeTransition.fromFrame = before;
    _keyboardDidChangeTransition.toFrame = after;
    _keyboardDidChangeTransition.animationCurve = curve;
    _keyboardDidChangeTransition.animationDuration = duration;
    
    [self notifyObservers];
    
}

- (void)notifyObservers
{
    if (!CGRectEqualToRect(_keyboardWillChangeTransition.toFrame, _keyboardDidChangeTransition.toFrame)) {
        for (id<BMKeyboardObserver> observer in _observers.copy) {
            if ([observer respondsToSelector:@selector(keyboardChangedWithTransition:)]) {
                [observer keyboardChangedWithTransition:_keyboardWillChangeTransition];
            }
        }
    }
}

@end

