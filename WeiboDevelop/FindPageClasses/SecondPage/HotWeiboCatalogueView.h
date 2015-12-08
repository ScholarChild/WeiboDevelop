//
//  HotWeiboCatalogueView.h
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotWeiboCatalogueView : UIView
{
    BOOL isEdit;                      // 是否正在编辑状态
    NSMutableArray *personalArray;    // 个人分类数据
    NSMutableArray *addArray;         // 添加分类数据
}

@property(strong)UIView *whiteview;
@property(strong)UIScrollView *bodyScroll;
@property(strong)UIView *personalCatalogueView;
@property(strong)UILabel *addlabel;
@property(strong)UIView *addCalalogueView;

@property(strong)UIButton *editBtn;

- (instancetype)init;

- (void)initWithPersonalCatalogue;

- (void)initWithAddCalalogue;

@end
