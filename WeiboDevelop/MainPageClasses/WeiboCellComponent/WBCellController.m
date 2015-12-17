//
//  WeiboViewFactory.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBCellController.h"
#import "CommentPageController.h"

@interface WBCellController()

@property (nonatomic,retain)UserInfoView* userInfo;
@property (nonatomic,retain)BodyView* body;
@property (nonatomic,retain)CellToolBar* toolBar;

@end

@implementation WBCellController

- (instancetype)initWithStatus:(WBStatus *)status
{
    if (self = [super init]) {
        _status = status;
        [self calcularHeight];
    }
    return self;
}

- (void)calcularHeight
{
    CGFloat topHeight = 50.0f;
    CGFloat centerHeight = [self bodyHeight];
    CGFloat buttomHeight = 30.0f;
    CGFloat cellHeight = topHeight + centerHeight + buttomHeight + weiboCellviewInterval;
    _heightOfCell = cellHeight;
}
- (CGFloat)bodyHeight
{
    return weiboCellviewInterval + [self textHeight:_status.text] + [self exBodyHeight];
}

- (CGFloat)textHeight:(NSString*)text
{
    UILabel* tmpLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    tmpLabel.text = text;
    CGFloat textWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - weiboCellviewInterval*2;
    CGSize textSize = [tmpLabel sizeThatFits:CGSizeMake(textWidth, CGFLOAT_MAX)];
    return textSize.height;
}
- (CGFloat)exBodyHeight
{
    CGFloat exBodyHeight = weiboCellviewInterval;
    return exBodyHeight;
}

#pragma mark constructCell

- (void)constructCell:(WBContainCell *)cell
{
    self.userInfo = cell.userInfo;
    self.body = cell.body;
    self.toolBar = cell.toolBar;
    [self prepareFromStatus];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)prepareFromStatus;
{
    [self setDataToView];
    [self layoutSubviews];
}

- (void)setDataToView
{
    WBUser* user = _status.user;
    WBStatus* retweet = _status.retweeted_status;
    
    [_userInfo setAvatarImgWithURL:[NSURL URLWithString:[user profile_image_url]]];
    [_userInfo setUserName:user.name];
    [_userInfo setCreateTime:_status.created_at];
    [_userInfo setSource:_status.source];
    
    [_toolBar setRepostCount:_status.reposts_count];
    [_toolBar setCommentCount:_status.comments_count];
    [_toolBar setAttitudeCount:_status.attitudes_count];
    
    __weak typeof(self) safeSelf = self;
    NSString* statusID = [_status.statusID stringValue];
    [_toolBar setCommendAction:^(NSInteger commitCount){
        CommentPageController* commentPage = [[CommentPageController alloc]initWithNumber:statusID];
        commentPage.hidesBottomBarWhenPushed=YES;
        [safeSelf.navigationController pushViewController:commentPage animated:YES];
        
    }];
    
    if (retweet == nil) {
        NSArray* urlArr = [self URLStringArrayFromURLDicArray:_status.pic_urls];
        [_body setBodyText:_status.text URLOfImagesAtBody:urlArr];
    }else {
        NSArray* urlArr = [self URLStringArrayFromURLDicArray:retweet.pic_urls];
        [_body setBodyText:_status.text retweetText:retweet.text retweetUser:retweet.user.name imagesAtRetweetBody:urlArr];
    }
}

- (NSArray* )URLStringArrayFromURLDicArray:(NSArray*)urlDicArr
{
    if (urlDicArr == nil) {
        return nil;
    }
    NSMutableArray* tmpArr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary* urlDic in urlDicArr) {
        [tmpArr addObject:[urlDic objectForKey:@"thumbnail_pic"]];
    }
    return [NSArray arrayWithArray:tmpArr];
}

- (void)layoutSubviews
{
    CGFloat topHeight = 50.0f;
    CGFloat centerHeight = _body.height;
    CGFloat buttomHeight = 30.0f;
    CGFloat winWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat cellHeight = topHeight + centerHeight + buttomHeight + weiboCellviewInterval;
    
    CGRect interval;
    
    CGRect remainder = CGRectMake(0, 0, winWidth, cellHeight);
    CGRect topFrame;
    CGRect centerFrame;
    CGRect buttomFrame;
    
    CGRectDivide(remainder, &interval, &remainder, weiboCellviewInterval, CGRectMinYEdge);
    CGRectDivide(remainder, &topFrame, &remainder, topHeight, CGRectMinYEdge);
    CGRectDivide(remainder, &centerFrame, &remainder, centerHeight, CGRectMinYEdge);
    CGRectDivide(remainder, &buttomFrame, &remainder, buttomHeight, CGRectMinYEdge);
    
    CGRectDivide(topFrame, &interval, &topFrame, weiboCellviewInterval, CGRectMinXEdge);
    CGRectDivide(topFrame, &interval, &topFrame, weiboCellviewInterval, CGRectMaxXEdge);
    
    _userInfo.frame = CGRectIntegral(topFrame);
    _body.frame = CGRectIntegral(centerFrame);
    _toolBar.frame = CGRectIntegral(buttomFrame);
    
    [_userInfo layoutSubviews];
    [_body layoutSubviews];
    [_toolBar layoutSubviews];
    
    _heightOfCell = cellHeight;
}
@end
