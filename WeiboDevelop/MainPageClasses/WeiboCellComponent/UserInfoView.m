//
//  BaseInfoView.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "UserInfoView.h"
#import "Datetransformer.h"
#import "UIImageView+WebCache.h"

@interface UserInfoView()

@property(nonatomic,retain)UIImageView* avatar;
@property(nonatomic,retain)UILabel* userNameLabel;
@property(nonatomic,retain)UILabel* detailMessage;
@property(nonatomic,retain)UIImageView* level;
@property(nonatomic,retain)NSString* createTime;
@property(nonatomic,retain)NSString* source;

@end


@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addCompomentWithFrame:frame];
    }
    return self;
}

- (void)addCompomentWithFrame:(CGRect)frame
{
    _avatar = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    [self addSubview:_avatar];
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_userNameLabel];
    
    _detailMessage = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_detailMessage];
}


- (void)layoutSubviews
{
    CGRect remainder = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGFloat myHeight = CGRectGetHeight(self.frame);
    CGRect avatarFrame = CGRectZero;
    CGRect bound = CGRectZero;
    CGRect nameFrame = CGRectZero;
    CGRect detailFrame = CGRectZero;
    CGRectDivide(remainder, &avatarFrame, &remainder, myHeight, CGRectMinXEdge);
    CGRectDivide(remainder, &bound, &remainder, myHeight / 6.0f, CGRectMinXEdge);
    CGRectDivide(remainder, &nameFrame, &remainder, myHeight*3/5, CGRectMinYEdge);
    CGRectDivide(remainder, &detailFrame, &remainder, myHeight*2/5, CGRectMinYEdge);
    
    _avatar.frame = CGRectIntegral(avatarFrame);
    _userNameLabel.frame = CGRectIntegral(nameFrame);
    _detailMessage.frame = CGRectIntegral(detailFrame);
    [self setCornerToAvtar];
}

- (void)setCornerToAvtar
{
    //圆角
    [_avatar.layer setCornerRadius:CGRectGetWidth(_avatar.frame) /2];
    [_avatar.layer setMasksToBounds:YES];
}

- (void)setAvatarImgWithURL:(NSURL *)imgURL
{
    [_avatar sd_setImageWithURL:imgURL];
    
}

- (void)setUserName:(NSString*)userName
{
    NSDictionary* attributeDic =
    @{
      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:21.0f],
      NSForegroundColorAttributeName : [UIColor orangeColor]
      };
    
    
    NSAttributedString* userNameAttr =
    [[NSAttributedString alloc]initWithString:userName attributes:attributeDic];
    _userNameLabel.attributedText = userNameAttr;
}

- (void)setCreateTime:(NSString *)createTime
{
    _createTime = createTime;
    [self updateDetail];
}

- (void)setSource:(NSString *)source
{
    _source = [self sourceNameBySearchSourceXMLString:source];
    [self updateDetail];
}

- (void)updateDetail
{
    NSDate* createTimeDate = [DateTransformer dateWithString:_createTime
                                                      format:@"E M dd HH:mm:ss Z yyyy"
                                                      locale:@"en_US"];
    NSString* timInterval = [DateTransformer timeIntervalStringForNowSinceDate:createTimeDate];
    
    NSString* detailStr;
    if (_source != nil) {
        detailStr = [NSString stringWithFormat:@"%@ 来自 %@",timInterval,_source];
    }else {
        detailStr = timInterval;
    }
    
    NSDictionary* detailAttribute =
    @{
      NSFontAttributeName : [UIFont systemFontOfSize:12.0]
      };

    
    NSMutableAttributedString* attributeDetail =
    [[NSMutableAttributedString alloc] initWithString:detailStr attributes:detailAttribute];
    
    NSRange timeIntervalRange = [attributeDetail.string rangeOfString:timInterval];
    [attributeDetail addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:timeIntervalRange];
    _detailMessage.attributedText = attributeDetail;
    
}

- (NSString*)sourceNameBySearchSourceXMLString:(NSString*)xmlStr
{
    NSString* sourceName;
    NSRange sourceNameRange = [xmlStr rangeOfString:@">.[^<>]+<" options:NSRegularExpressionSearch];
    if (sourceNameRange.location != NSNotFound) {
        sourceNameRange.location ++;
        sourceNameRange.length -= 2;
        sourceName = [xmlStr substringWithRange:sourceNameRange];
    }
    return sourceName;
}

@end





















