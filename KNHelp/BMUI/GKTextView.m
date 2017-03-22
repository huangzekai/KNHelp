//
//  GKTextView.m
//  BMComLibrary
//
//  Created by king on 16/8/4.
//  Copyright © 2016年 kennyhuang. All rights reserved.
//

#import "GKTextView.h"

#define kDefaultMaxLength 10000

@interface GKTextView ()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView *textView;

@property (nonatomic ,strong) UILabel *lengthLbl;

@end


@implementation GKTextView

- (instancetype)init
{
    if (self = [super init]) {
        [self setUpChildViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpChildViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpChildViews];
    }
    return self;
}

- (void)setUpChildViews
{
    self.isShowLength = YES;
    
    [self addSubview:self.textView];
    [self addSubview:self.placeHolderLbl];
    [self addSubview:self.lengthLbl];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
    self.placeHolderLbl.frame = CGRectMake(15, 9, CGRectGetWidth(self.bounds) - 30, CGRectGetHeight(self.placeHolderLbl.bounds));
    [self changeLengthLblFrame];
}

- (void)changeLengthLblFrame
{
    CGFloat y = 0;
    switch (self.lengthTipsLocation) {
        case LengthTipsLocationInside:
            y =  CGRectGetHeight(self.frame) - CGRectGetHeight(self.lengthLbl.frame);
            break;
        case LengthTipsLocationBelow:
            y = CGRectGetHeight(self.frame);
            break;
            
        default:
            break;
    }
    
    self.lengthLbl.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.lengthLbl.frame), y, CGRectGetWidth(self.lengthLbl.frame), CGRectGetHeight(self.lengthLbl.frame));
}


///检查输入
- (BOOL)isContentLegal
{
    NSString *content = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (content.length <= 0)
    {
        return NO;
    }
    return YES;
}

//提示剩余文字长度
- (void)changeTipsLength
{
    self.lengthLbl.text = [NSString stringWithFormat:@"%d",self.maxStingLength - (int)self.textView.text.length];
    [self.lengthLbl sizeToFit];
}

#pragma mark textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(gkTextView:shouldChangeTextInRange:replacementText:)]) {
        [self.delegate gkTextView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    if (self.maxStingLength <= 0) {
        self.maxStingLength = kDefaultMaxLength;
    }
    if (textView.text.length >= self.maxStingLength && text.length > range.length) {
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(gkTextViewDidChange:)]) {
        [self.delegate gkTextViewDidChange:textView];
    }
//    self.inputText = textView.text;
    
    if (self.maxStingLength <= 0) {
        self.maxStingLength = kDefaultMaxLength;
    }
    
    if (self.textView.text.length == 0 )
    {
        self.placeHolderLbl.hidden = NO;
    }
    else
    {
        self.placeHolderLbl.hidden = YES;
    }
    
    //限制字数
    //取得输入法
    NSString *inputMode = [[UITextInputMode currentInputMode] primaryLanguage];
    if ([inputMode isEqualToString:@"zh-Hans"]||[inputMode isEqualToString:@"zh-Hant"]) {//如果是中文输入法，则需要特殊处理
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        //判断是否有高亮字
        if (!position) {//如果没有高亮字，则取字数限制
            if (self.textView.text.length > self.maxStingLength) {
                self.textView.text = [self.textView.text substringToIndex:self.maxStingLength];
            }
            //如果有高亮字，表明正在输入，那么不做字数限制
        }
    }
    else{//其他输入法的情况下，则直接限制字数
        if (self.textView.text.length > self.maxStingLength) {
            self.textView.text = [self.textView.text substringToIndex:self.maxStingLength];
        }
    }
    
    [self changeTipsLength];
}






#pragma mark setter getter

- (UILabel *)placeHolderLbl
{
    if (!_placeHolderLbl) {
        _placeHolderLbl = [[UILabel alloc] init];
        _placeHolderLbl.numberOfLines = 0;
        _placeHolderLbl.font = [UIFont systemFontOfSize:13];
        _placeHolderLbl.textAlignment = NSTextAlignmentLeft;
        _placeHolderLbl.numberOfLines = 0;
        _placeHolderLbl.textColor = [UIColor grayColor];
        _placeHolderLbl.text = @"88";
        [_placeHolderLbl sizeToFit];
    }
    return _placeHolderLbl;
}

- (UILabel *)lengthLbl
{
    if (!_lengthLbl) {
        _lengthLbl = [[UILabel alloc] init];
        _lengthLbl.font = [UIFont systemFontOfSize:10];
        _lengthLbl.textAlignment = NSTextAlignmentRight;
        _lengthLbl.alpha = 0.6;
        _lengthLbl.backgroundColor = [UIColor grayColor];
        _lengthLbl.textColor = [UIColor whiteColor];
        _lengthLbl.text = [NSString stringWithFormat:@"%d",self.maxStingLength - (int)self.textView.text.length];
    }
    return _lengthLbl;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
        _textView.delegate = self;
    }
    return _textView;
}

- (void)setTextFont:(CGFloat)textFont
{
    _textFont = textFont;
    self.textView.font = [UIFont systemFontOfSize:textFont];
    self.placeHolderLbl.font = [UIFont systemFontOfSize:textFont];
    [self.placeHolderLbl sizeToFit];
}

- (NSString *)inputText
{
    return self.textView.text;
}

- (void)setMaxStingLength:(uint)maxStingLength
{
    _maxStingLength = maxStingLength;
    if (_maxStingLength > 0) {
        self.isShowLength = YES;
        [self changeTipsLength];
    }
}

- (void)setIsShowLength:(BOOL)isShowLength
{
    _isShowLength = isShowLength;
    if (self.maxStingLength > 0) {
        self.lengthLbl.hidden = !isShowLength;
    }else{
        self.lengthLbl.hidden = YES;
    }
}

- (BOOL)isLegalString
{
    return [self isContentLegal];
}

- (void)setLengthTipsLocation:(GKLengthTipsLocation)lengthTipsLocation
{
    _lengthTipsLocation = lengthTipsLocation;
    [self changeLengthLblFrame];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textView.textColor = textColor;
}

@end
