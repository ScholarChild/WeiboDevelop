//
//  ButtomMenu.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "CellToolBar.h"

@interface CellToolBar()

@property (nonatomic,assign)UIButton* repost;// 转发
@property (nonatomic,assign)UIButton* comment;// 评论
@property (nonatomic,assign)UIButton* attitude;// 表态
@property (nonatomic,assign)BOOL isLike;

@end

@implementation CellToolBar
#pragma mark setter

- (void)setRepostCount:(NSNumber *)repostCount
{
    [_repost setTitle:[repostCount  stringValue] forState:UIControlStateNormal];
}

- (void)setCommentCount:(NSNumber *)commentCount
{
    [_comment setTitle:[commentCount stringValue] forState:UIControlStateNormal];
}

- (void)setAttitudeCount:(NSNumber *)attitudeCount
{
    [_attitude setTitle:[attitudeCount stringValue] forState:UIControlStateNormal];
}

#pragma mark layout
- (void)layoutSubviews
{
    CGRect slice;
    CGRect remainder = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGFloat btnWidth = CGRectGetWidth(self.frame)/3;
    CGRectDivide(remainder, &slice, &remainder, btnWidth, CGRectMinXEdge);
    _repost.frame = CGRectIntegral(slice);
    CGRectDivide(remainder, &slice, &remainder, btnWidth, CGRectMinXEdge);
    _comment.frame = CGRectIntegral(slice);
    _attitude.frame = CGRectIntegral(remainder);
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isLike = NO;
        [self addCompomentWithFrame:frame];
        [self setBtnImage];
    }
    return self;
}

- (void)addCompomentWithFrame:(CGRect)frame
{
    _repost = [UIButton buttonWithType:UIButtonTypeCustom];
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    _attitude = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_repost addTarget:self action:@selector(repose:) forControlEvents:UIControlEventTouchUpInside];
    [_comment addTarget:self action:@selector(commend:) forControlEvents:UIControlEventTouchUpInside];
    [_attitude addTarget:self action:@selector(attitude:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray* btnArr = @[_repost,_comment,_attitude];
    for (UIButton* btn in btnArr) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    [self addSubview:_comment];
    [self addSubview:_repost];
    [self addSubview:_attitude];
}

- (void)setBtnImage
{
    NSString* imgGroup = @"toolbar_icon";
    NSString* size = @"@3x";
    NSString* type = @".png";
    NSString* retweedImgName = [NSString stringWithFormat:@"%@_retweet%@%@",imgGroup,size,type];
    NSString* commendImgName = [NSString stringWithFormat:@"%@_comment%@%@",imgGroup,size,type];
    NSString* attitudeImgName = [NSString stringWithFormat:@"%@_unlike%@%@",imgGroup,size,type];
    
    UIImage* retweedImg = [UIImage imageNamed:retweedImgName];
    UIImage* commendImg = [UIImage imageNamed:commendImgName];
    UIImage* attitudeImg = [UIImage imageNamed:attitudeImgName];
    
    [_repost setImage:retweedImg forState:UIControlStateNormal];
    [_comment setImage:commendImg forState:UIControlStateNormal];
    [_attitude setImage:attitudeImg forState:UIControlStateNormal];
}
#pragma mark action

- (void)attitude:(UIButton*)attitudeBtn
{
    NSString* imgGroup = @"toolbar_icon";
    NSString* size = @"@3x";
    NSString* type = @".png";
    NSString* attitudeImgName;
    NSInteger attitude = [_attitude.titleLabel.text integerValue];
    _isLike = !_isLike;
    if (_isLike) {
        attitude++;
        attitudeImgName = [NSString stringWithFormat:@"%@_like%@%@",imgGroup,size,type];
    }else{
        attitude--;
        attitudeImgName = [NSString stringWithFormat:@"%@_unlike%@%@",imgGroup,size,type];
    }
    self.attitudeCount = [NSNumber numberWithInteger:attitude];
    UIImage* attitudeImg = [UIImage imageNamed:attitudeImgName];
    [_attitude setImage:attitudeImg forState:UIControlStateNormal];
    [_attitude setTitle:[NSString stringWithFormat:@"%lu",attitude] forState:UIControlStateNormal];
}

- (void)repose:(UIButton*)reposeBtn
{
    NSInteger reposeCount = [reposeBtn.titleLabel.text integerValue];
    if (self.repostAction) {
        self.repostAction(reposeCount);
    }
    
}
- (void)commend:(UIButton*)commendBtn
{
    NSInteger commendCount = [commendBtn.titleLabel.text integerValue];
    NSLog(@">>>>>%@",_commendAction);
    
    if (self.commendAction) {
        self.commendAction(commendCount);
    }
}



@end



















