//
//  WeiboView.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WeiboCell.h"
#import "UserInfoView.h"
#import "CellToolBar.h"
#import "BodyView.h"

@interface WeiboCell()

@end

@implementation WeiboCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _userInfo = [[UserInfoView alloc]initWithFrame:CGRectZero];
    _body = [[BodyView alloc]initWithFrame:CGRectZero];
    _toolBar = [[CellToolBar alloc]initWithFrame:CGRectZero];
    [self addSubview:_userInfo];
    [self addSubview:_body];
    [self addSubview:_toolBar];
}


//- (void)setUserInfo:(UserInfoView *)userInfo
//{
//    if (_userInfo == userInfo) {
//        return;
//    }
//    [_userInfo removeFromSuperview];
//    _userInfo = userInfo;
//    [self addSubview:_userInfo];
//}
//- (void)setBody:(BodyView *)body
//{
//    if (_body == body) {
//        return;
//    }
//    [_body removeFromSuperview];
//    _body = body;
//    [self addSubview:_body];
//}
//
//- (void)setToolBar:(CellToolBar *)toolBar
//{
//    if (_toolBar == toolBar) {
//        return;
//    }
//    [_toolBar removeFromSuperview];
//    _toolBar = toolBar;
//    [self addSubview:_toolBar];
//}


@end



