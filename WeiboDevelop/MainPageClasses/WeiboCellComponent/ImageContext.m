//
//  ImageContext.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "ImageContext.h"
#import "UIImageView+WebCache.h"
#import "ImageSizeDownLoader.h"

@interface ImageContext()<NSURLConnectionDataDelegate>

@end


@implementation ImageContext
@synthesize height = _height;
- (CGFloat)height
{
    [self layoutSubviews];
    return _height;
}

- (void)setImagesWithUrlArr:(NSArray *)urlArray
{
    CGFloat viewHeight = 0;
    
    if ([urlArray count] == 1) {
        viewHeight = [self onePicModeWithURLString:[urlArray objectAtIndex:0]];
    }else {
        viewHeight = [self ninePicModeWithURLStrArr:urlArray];
    }
    _height = viewHeight + weiboCellviewInterval*2;
}



- (CGFloat)ninePicModeWithURLStrArr:(NSArray*)urlStrArr
{
    CGFloat height = 0;
    
    NSInteger index = 0;
    NSInteger count = [urlStrArr count];
    NSInteger remainder = count;
    
    CGFloat imgInteval = weiboCellviewInterval / 3.0f;
    CGFloat contextWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - weiboCellviewInterval*2.0f;
    CGFloat positionInterval = contextWidth / 3.0f;
    CGFloat imgEdgeLength = (contextWidth - imgInteval*2) / 3;
    
    
    for (int row = 0; row < 3; row ++) {
        NSInteger colCount = (remainder >= 3) ? 3 : remainder;
        for (NSInteger col = 0; col < colCount; col++) {
            
            UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(positionInterval*col + weiboCellviewInterval, positionInterval*row + weiboCellviewInterval, imgEdgeLength, imgEdgeLength)];
            NSURL* imgURL = [NSURL URLWithString:[urlStrArr objectAtIndex:index]];
            [imgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"def.png"]];
            [self addSubview:imgView];
            index++;
        }
        if (remainder <= 0) {
            break;
        }
        remainder -= 3;
        height += positionInterval;
    }
    
    return height;
}

- (CGFloat)onePicModeWithURLString:(NSString *)urlString
{
    NSURL* imgURL = [NSURL URLWithString:urlString];
    
    CGSize imgSize = [ImageSizeDownLoader downloadImageSizeWithURL:imgURL];
    CGFloat contextWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - weiboCellviewInterval*2.0f;
    CGFloat imgPrintWidth = imgSize.width;
    CGFloat imgPrintHeight = imgSize.height;
    CGFloat aspectRatio = imgSize.width / imgSize.height;
    
    NSAssert((aspectRatio > 0.0f), @"单图加载异常！图片尺寸获取失败");
    
    if (aspectRatio >= 2.5f) {
        imgPrintWidth = contextWidth;
    }else if (aspectRatio >= 0.9f) {
        imgPrintWidth = contextWidth * 2.0f / 3.0f;
    }else {
        imgPrintWidth = contextWidth * 1.0f / 2.0f;
    }
    imgPrintHeight = imgPrintWidth / aspectRatio;
    
    CGRect imgPrintFrame = CGRectMake(weiboCellviewInterval, weiboCellviewInterval, imgPrintWidth, imgPrintHeight);
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectIntegral(imgPrintFrame)];
    [imgView setBackgroundColor:[UIColor yellowColor]];
    [imgView sd_setImageWithURL:imgURL];
    [self addSubview:imgView];
    return imgPrintHeight;
}

@end









