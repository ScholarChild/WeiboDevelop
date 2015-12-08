//
//  BodyView.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "BodyView.h"
#import "WBURLAnalyser.h"
#import "TextAttributeTranster.h"


@interface BodyView()<UITextViewDelegate>
{
    UITextView* _textView;
    UIView<LayoutHeight> *_exBody;
}

@end

@implementation BodyView
@synthesize height = _height;

- (CGFloat)height
{
    [self layoutSubviews];
    return _height;
}

- (void)layoutSubviews
{
    [self layoutTextLabel];
    CGFloat exBodyHeight =  (_exBody) ? _exBody.height : weiboCellviewInterval;
    
    CGFloat headHeight = CGRectGetHeight(_textView.frame);
    CGFloat bodyHeight = headHeight + exBodyHeight;
    
    CGRect remainder = CGRectMake(0, 0, CGRectGetWidth(self.frame), bodyHeight);
    CGRect exBodyFrame = CGRectZero;
    CGRectDivide(remainder, &remainder, &exBodyFrame, headHeight, CGRectMinYEdge);
    _exBody.frame = CGRectIntegral(exBodyFrame);
    _height = floor(bodyHeight);
}

- (void)layoutTextLabel
{
    CGFloat textWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize textSize = [_textView sizeThatFits:CGSizeMake(textWidth, CGFLOAT_MAX)];
    CGFloat textHeight = textSize.height;
    CGRect textFrame = CGRectMake(0, 0, textWidth, textHeight);
    _textView.frame = CGRectIntegral(textFrame);
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTextLabel];
    }
    return self;
}


- (void)addTextLabel
{
    _textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [_textView setEditable:NO];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor yellowColor];
    
    
    
    [self addSubview:_textView];
}



#pragma mark setBody

- (void)setBodyText:(NSString *)text retweetText:(NSString*)retweetText retweetUser:(NSString*)userName
{
    [self setBodyText:text retweetText:retweetText retweetUser:userName imagesAtRetweetBody:nil];
}

- (void)setBodyText:(NSString *)text retweetText:(NSString *)retweetText retweetUser:(NSString *)userName imagesAtRetweetBody:(NSArray *)urlArray
{
    [self setBodyText:text];
    if (retweetText && userName) {
        NSString* exText = [NSString stringWithFormat:@"@%@ :%@",userName,retweetText];
        BodyView* retweetBody = [[BodyView alloc]initWithFrame:CGRectZero];
        [retweetBody setBodyText:exText URLOfImagesAtBody:urlArray];
        [self setExBody:retweetBody];
        
        [retweetBody setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        for (UIView* subviews in [retweetBody subviews]) {
            [subviews setBackgroundColor:[UIColor clearColor]];
        }
    }
}

- (void)setBodyText:(NSString *)text URLOfImagesAtBody:(NSArray *)urlArray
{
    [self setBodyText:text];
    if (urlArray) {
        ImageContext* context = [[ImageContext alloc]initWithFrame:CGRectZero];
        [context setImagesWithUrlArr:urlArray];
        [self setExBody:context];
    }
}

- (void)setBodyText:(NSString*)text
{
    
    _textView.attributedText = [[[TextAttributeTranster alloc]initWithString:text] attrubuteText];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"url:%@ ,range:%@",URL,[NSValue valueWithRange:characterRange]);
    
    return NO;
}


- (void)setExBody:(UIView<LayoutHeight> *)exBody
{
    if (_exBody) {
        [_exBody removeFromSuperview];
    }
    _exBody = exBody;
    [self addSubview:_exBody];
}

@end















