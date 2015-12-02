//
//  HotWeiboCatalogueView.m
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "HotWeiboCatalogueView.h"

#define row 4
#define line 4

@implementation HotWeiboCatalogueView

- (instancetype)init
{
    if (self = [super init]) {
        self.whiteview = [[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 30)];
        self.whiteview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteview];
        
        //我的分类UILable
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        [label setText:@"我的分类"];
        label.font = [UIFont fontWithName:@"Arial" size:15];
        [self.whiteview addSubview:label];
        
        //btnAddorDelete按钮
        UIButton *btnAddorDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnAddorDelete setTitle:@"△" forState:UIControlStateNormal];
        [btnAddorDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnAddorDelete.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 0, 30, 30);
        [btnAddorDelete addTarget:self action:@selector(btnAddorDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteview addSubview:btnAddorDelete];
        
        //编辑按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(CGRectGetMinX(btnAddorDelete.frame) - 60, 5, 50, 20);
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button setTintColor:[UIColor orangeColor]];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor orangeColor].CGColor;
        button.layer.cornerRadius = 10;
        [self.whiteview addSubview:button];
        
        //bodyScroll显示具体内容
        self.bodyScroll = [[UIScrollView alloc] init];
        self.bodyScroll.frame = CGRectMake(0, CGRectGetMaxY(self.whiteview.frame)+1, [UIScreen mainScreen].bounds.size.width,0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        self.bodyScroll.frame = CGRectMake(0, CGRectGetMaxY(self.whiteview.frame)+1, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - (CGRectGetMaxY(self.whiteview.frame)+1));
        [UIView commitAnimations];
        self.bodyScroll.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self addSubview:self.bodyScroll];
        
        //我的分类视图
        [self initWithPersonalCatalogue];
        
        //点击添加分类
        self.addlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.personalCatalogueView.frame), [UIScreen mainScreen].bounds.size.width - 20, 30)];
        [self.addlabel setText:@"点击添加分类"];
        [self.addlabel setFont:[UIFont fontWithName:@"Arial" size:15]];
        [self.bodyScroll addSubview:self.addlabel];
        
        //添加分类视图
        [self initWithAddCalalogue];
    }
    return self;
}

- (void)initWithPersonalCatalogue
{
    CGFloat height = 0.0;
    self.personalCatalogueView = [[UIView alloc] init];
    for(int i = 1 ; i <= row; i++){
        for (int y = 1; y <= line; y++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"推荐" forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake((y-1) * [UIScreen mainScreen].bounds.size.width/4+10,30*(i-1)+5*i, [UIScreen mainScreen].bounds.size.width/4 - 20, 30);
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.cornerRadius = 5;
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.personalCatalogueView addSubview:button];
            if (i == row && y == line) {
                height = CGRectGetMaxY(button.frame);
            }
        }
    }
    self.personalCatalogueView.frame = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, height+5);
    self.personalCatalogueView.backgroundColor = [UIColor whiteColor];
    [self.bodyScroll addSubview:self.personalCatalogueView];
}

- (void)initWithAddCalalogue
{
    CGFloat height = 0.0;
    self.addCalalogueView = [[UIView alloc] init];
    for(int i = 1 ; i <= row; i++){
        for (int y = 1; y <= line; y++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"推荐" forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake((y-1) * [UIScreen mainScreen].bounds.size.width/4+10,30*(i-1)+5*i, [UIScreen mainScreen].bounds.size.width/4 - 20, 30);
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.cornerRadius = 5;
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.addCalalogueView addSubview:button];
            if (i == row && y == line) {
                height = CGRectGetMaxY(button.frame);
            }
        }
    }
    self.addCalalogueView.frame = CGRectMake(0, CGRectGetMaxY(self.addlabel.frame), [UIScreen mainScreen].bounds.size.width, height+5);
    self.addCalalogueView.backgroundColor = [UIColor whiteColor];
    [self.bodyScroll addSubview:self.addCalalogueView];
}

- (void)btnAction:(UIButton *)button
{
    
}

- (void)btnAddorDeleteAction:(UIButton *)button
{
    [self removeFromSuperview];
}

@end
