//
//  Find_SearchViewController.h
//  WeiboFind
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"
#import "Find_SearchView.h"
#import "Find_SearchModal.h"

@interface Find_SearchViewController : UIViewController

@property(nonatomic)FindViewController *delegate;
@property(strong)Find_SearchView *searchView;
@property(nonatomic)Find_SearchModal *searchModal;

//构建未搜索时模型数据及显示视图
- (void)initWithFind_SearchView;

//构建搜索时模型数据及显示视图
- (void)initWithFind_SearchView2;

@end
