//
//  BMGIFImageView.m
//
//  gif播放视图
//  Created by kennyHuang on 15-06-08.
//  Copyright (c) 2015年 kennykhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNGIFImageView.h"


@interface BMGIFManager : NSObject
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSHashTable *gifViewHashTable;

+ (BMGIFManager *)shared;
- (void)stopGIFView:(KNGIFImageView *)view;
@end


@implementation BMGIFManager

+ (BMGIFManager *)shared
{
    static BMGIFManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BMGIFManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
	self = [super init];
	if (self)
    {
		_gifViewHashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
	}
	return self;
}

- (void)play
{
    for (KNGIFImageView *imageView in _gifViewHashTable)
    {
        [imageView performSelector:@selector(play)];
    }
}

- (void)stopDisplayLink
{
    if (self.displayLink)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)stopGIFView:(KNGIFImageView *)view
{
    [_gifViewHashTable removeObject:view];
    if (_gifViewHashTable.count<1 && !_displayLink)
    {
        [self stopDisplayLink];
    }
}
@end







#import "KNGIFImageView.h"

@interface KNGIFImageView()
{
    NSInteger           _index;
    NSInteger           _frameCount;
    CGFloat             _timestamp;
    CGImageSourceRef    _gifSourceRef;
}
@end



@implementation KNGIFImageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _animationRepeatInterval = 1;
    }
    return self;
}

- (void)startGIF
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        if (![[BMGIFManager shared].gifViewHashTable containsObject:self])
        {
            if ((self.gifData || self.gifPath)) {
                CGImageSourceRef gifSourceRef;
                if (self.gifData) {
                    gifSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)(self.gifData), NULL);
                }else{
                    gifSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:self.gifPath], NULL);
                }
                if (!gifSourceRef) {
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[BMGIFManager shared].gifViewHashTable addObject:self];
                    _gifSourceRef = gifSourceRef;
                    _frameCount = CGImageSourceGetCount(gifSourceRef);
                });
            }
        }
    });
    if (![BMGIFManager shared].displayLink)
    {
        [BMGIFManager shared].displayLink = [CADisplayLink displayLinkWithTarget:[BMGIFManager shared] selector:@selector(play)];
        [[BMGIFManager shared].displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)stopGIF
{
    if (_gifSourceRef)
    {
        CFRelease(_gifSourceRef);
        _gifSourceRef = nil;
    }
    [[BMGIFManager shared] stopGIFView:self];
}

- (void)play
{
    float nextFrameDuration = [self frameDurationAtIndex:MIN(_index+1, _frameCount-1)];
    if (_index == _frameCount - 1) {
        nextFrameDuration += self.animationRepeatInterval;
    }
    
    if (_timestamp < nextFrameDuration) {
        _timestamp += [BMGIFManager shared].displayLink.duration;
        return;
    }
	_index ++;
	_index = _index%_frameCount;
	CGImageRef ref = CGImageSourceCreateImageAtIndex(_gifSourceRef, _index, NULL);
	self.layer.contents = (__bridge id)(ref);
    CGImageRelease(ref);
    _timestamp = 0;
}

- (BOOL)isGIFPlaying
{
    return _gifSourceRef ? YES : NO;
}

- (float)frameDurationAtIndex:(size_t)index
{
    CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(_gifSourceRef, index, NULL);
    NSDictionary *dict = (__bridge NSDictionary *)dictRef;
    NSDictionary *gifDict = (dict[(NSString *)kCGImagePropertyGIFDictionary]);
    NSNumber *unclampedDelayTime = gifDict[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    NSNumber *delayTime = gifDict[(NSString *)kCGImagePropertyGIFDelayTime];
    CFRelease(dictRef);
    if (unclampedDelayTime.floatValue)
    {
        return unclampedDelayTime.floatValue;
    }
    else if (delayTime.floatValue)
    {
        return delayTime.floatValue;
    }
    else
    {
        return 1/15;
    }
}

@end
