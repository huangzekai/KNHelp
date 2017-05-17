//
//  BMGIFImageView.h
//
//  gif播放视图
//  Created by kennyHuang on 15-06-6-08.
//  Copyright (c) 2014年 kennykhuang All rights reserved.
//

//注:gif播放视图
//   支持播放本地gif本地文件，不支持播放网络gif
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

@interface KNGIFImageView : UIImageView
@property (nonatomic, strong) NSString *gifPath;
@property (nonatomic, strong) NSData *gifData;
///动画重复播放的时间间隔
@property (nonatomic) NSInteger animationRepeatInterval;
- (void)startGIF;
- (void)stopGIF;
- (BOOL)isGIFPlaying;
@end
