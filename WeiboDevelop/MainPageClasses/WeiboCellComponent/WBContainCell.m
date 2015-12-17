//
//  WeiboView.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBContainCell.h"
#import "UserInfoView.h"
#import "CellToolBar.h"
#import "BodyView.h"

@interface WBContainCell()

@end

@implementation WBContainCell


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

@end



