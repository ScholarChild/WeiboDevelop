//
//  BodyView.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "BodyView.h"



@interface BodyView()
{
    UILabel* _textLabel;
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
    
    CGFloat headHeight = weiboCellviewInterval + CGRectGetHeight(_textLabel.frame);
    CGFloat bodyHeight = headHeight + exBodyHeight;
    
    CGRect remainder = CGRectMake(0, 0, CGRectGetWidth(self.frame), bodyHeight);
    CGRect exBodyFrame = CGRectZero;
    CGRectDivide(remainder, &remainder, &exBodyFrame, headHeight, CGRectMinYEdge);
    _exBody.frame = CGRectIntegral(exBodyFrame);
    _height = floor(bodyHeight);
}

- (void)layoutTextLabel
{
    CGFloat textWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - weiboCellviewInterval*2;
    CGSize textSize = [_textLabel sizeThatFits:CGSizeMake(textWidth, CGFLOAT_MAX)];
    CGFloat textHeight = textSize.height;
    CGRect textFrame = CGRectMake(weiboCellviewInterval, weiboCellviewInterval, textWidth, textHeight);
    _textLabel.frame = CGRectIntegral(textFrame);
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
    _textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _textLabel.numberOfLines = 0;
    _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_textLabel];
}



#pragma mark setBody
- (void)setBodyText:(NSString*)text
{
    _textLabel.text = text;;
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
        [retweetBody setBodyText:exText];
        [retweetBody setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        [self setExBody:retweetBody];
        
        if (urlArray) {
            ImageContext* context = [[ImageContext alloc]initWithFrame:CGRectZero];
            [context setImagesWithUrlArr:urlArray];
            [retweetBody setExBody:context];
        }
    }
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


















