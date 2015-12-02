//
//  WeiboViewFactory.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboCell.h"
#import "WBStatus.h"
#import "WBUser.h"

#import "UserInfoView.h"
#import "BodyView.h"
#import "CellToolBar.h"


@interface WBCellPreparer : NSObject

@property (nonatomic,readonly)CGFloat heightOfCell;


- (instancetype)initWithStatus:(WBStatus*)status;
- (void)constructCell:(WeiboCell*)cell;

@end
