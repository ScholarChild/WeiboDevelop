//
//  Find_SearchView.h
//  WeiboFind
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"

@interface Find_SearchView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic)FindViewController *delegate;
@property(strong)UITableView *searchTable;

//初始化的视图
- (void)initWithFind_SearchViewWithDictionary:(NSDictionary *)dic;

//搜索显示视图
- (void)initWithFind_SearchView2WithDictionary:(NSDictionary *)dic;

@end
