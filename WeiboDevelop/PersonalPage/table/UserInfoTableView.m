//
//  UserInfoTableView.m
//  WeiBo
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import "UserInfoTableView.h"

@implementation UserInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.rowHeight = 40;
        self.backgroundColor = [UIColor colorWithRed:((Byte)(0xD4D4D4 >> 16))/255.0 green:((Byte)(0xD4D4D4 >> 8))/255.0 blue:((Byte)0xD4D4D4)/255.0 alpha:1];
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    }
    return self;
}

@end
