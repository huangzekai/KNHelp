//
//  GKTextView.h
//  BMComLibrary
//
//  Created by king on 16/8/4.
//  Copyright © 2016年 kennyhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LengthTipsLocationInside,
    LengthTipsLocationBelow
}GKLengthTipsLocation;


@protocol GKTextViewDelegate <NSObject>

@optional
- (void)gkTextViewDidChange:(UITextView *)textView;
- (BOOL)gkTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
@end

@interface GKTextView : UIView

@property (nonatomic ,weak) id<GKTextViewDelegate> delegate;

@property (nonatomic ,strong) UILabel *placeHolderLbl;

@property (nonatomic ,strong)UIColor *textColor;
//default input length is 10000
@property (nonatomic ,assign) uint maxStingLength;

@property (nonatomic ,strong, readonly) NSString *inputText;
//default is 13
@property (nonatomic ,assign) CGFloat textFont;
//default is YES
@property (nonatomic ,assign) BOOL isShowLength;
//is inputString has word
@property (nonatomic ,assign, readonly) BOOL isLegalString;
//default is LengthTipsLocationInside
@property (nonatomic ,assign) GKLengthTipsLocation lengthTipsLocation;
@end
