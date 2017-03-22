//
//  HZYIndicatorView.m
//  test
//
//  Created by jacky on 16/7/22.
//  Copyright © 2016年 com.bemetoy.Bemetoy. All rights reserved.
//

#import "HZYIndicatorView.h"


#define kIndicatorAnimation @"kIndicatorAnimation"

@interface HZYIndicatorView ()

@property(nonatomic,strong) NSMutableArray *beginPoints;
@property(nonatomic,strong) NSMutableArray *endPoints;

@end

@implementation HZYIndicatorView

- (instancetype)init
{
    if (self = [super init]) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [self.beginPoints enumerateObjectsUsingBlock:^(NSValue *beginValue, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint endPoint = [self.endPoints[idx] CGPointValue];
        CGPoint beginPoint = [beginValue CGPointValue];
        
        if (self.lineColor) {
            [self.lineColor set];
        }else{
            [[UIColor blackColor] set];
        }
        
        if (self.opacity) {
            if (!CGPointEqualToPoint(self.opacityRange, CGPointZero)) {
                CGFloat range = self.opacityRange.y - self.opacityRange.x;
                CGContextSetAlpha(ref, (CGFloat)idx/(CGFloat)self.endPoints.count * range + self.opacityRange.x);
            }else{
                CGContextSetAlpha(ref, (CGFloat)idx/(CGFloat)self.endPoints.count);
            }
        }
        
        CGContextSetLineWidth(ref, 3);
        CGContextSetLineCap(ref, kCGLineCapRound);
        CGContextMoveToPoint(ref, beginPoint.x, beginPoint.y);
        CGContextAddLineToPoint(ref, endPoint.x, endPoint.y);
        
//        NSLog(@"beginP : %@   endP : %@",NSStringFromCGPoint(beginPoint),NSStringFromCGPoint(endPoint));
        CGContextStrokePath(ref);
    }];
}

- (void)drawChrysanthemumWithPoint:(CGPoint)centerPoint radius:(CGFloat)radius petalNum:(NSUInteger)number petalLength:(CGFloat)length
{
    [self.beginPoints removeAllObjects];
    [self.endPoints removeAllObjects];
    
    CGFloat perAngel = 2 * M_PI / number;
    for (int i = 0 ; i < number ; i++) {
        CGFloat beginY = sin(perAngel * i) * radius;
        CGFloat beginX = cos(perAngel * i) * radius;
        CGPoint beginPoint = CGPointMake(beginX + centerPoint.x, beginY + centerPoint.y);
        [self.beginPoints addObject:[NSValue valueWithCGPoint:beginPoint]];
        
        CGFloat endY = sin(perAngel * i) * (radius + length);
        CGFloat endX = cos(perAngel * i) * (radius + length);
        CGPoint endPoint = CGPointMake(endX + centerPoint.x, endY + centerPoint.y);
        [self.endPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    }
    
    [self setNeedsDisplay];
}

- (BOOL)checkValue:(CGFloat)value
{
    if (value >= 0 && value <= 1) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - Animation
- (void)startAnimation
{
    if ([self isAnimation]) {
        return;
    }
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.fromValue = @(0);
    anima.toValue = @(2 * M_PI);
    anima.duration = 2;
    anima.repeatCount = CGFLOAT_MAX;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anima forKey:kIndicatorAnimation];
}

- (void)stopAnimation
{
    [self.layer removeAnimationForKey:kIndicatorAnimation];
}

- (BOOL)isAnimation
{
    return [self.layer animationForKey:kIndicatorAnimation]?YES:NO;
}

- (void)setOpacityRange:(CGPoint)opacityRange
{
    NSAssert([self checkValue:opacityRange.x] && [self checkValue:opacityRange.y] && opacityRange.y >= opacityRange.x, @"opacity range value is not in 0~1 OR opacity max value is smaller than opacity min value");
    
    _opacityRange = opacityRange;
}

- (NSMutableArray *)beginPoints
{
    if (!_beginPoints) {
        _beginPoints = [[NSMutableArray alloc] init];
    }
    return _beginPoints;
}

- (NSMutableArray *)endPoints
{
    if (!_endPoints) {
        _endPoints = [[NSMutableArray alloc] init];
    }
    return _endPoints;
}


@end
