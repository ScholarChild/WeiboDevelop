//
//  WeiboView.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"
#import "CellToolBar.h"
#import "BodyView.h"

@class WBCellPreparer;
@interface WeiboCell : UITableViewCell

@property(nonatomic,retain)UserInfoView* userInfo;
@property(nonatomic,retain)BodyView* body;
@property(nonatomic,retain)CellToolBar* toolBar;

@end
