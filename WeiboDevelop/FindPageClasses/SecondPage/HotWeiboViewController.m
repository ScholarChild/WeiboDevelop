//
//  HotWeiboViewController.m
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "HotWeiboViewController.h"
#import "HotWeiboCatalogueView.h"

@interface HotWeiboViewController ()

@end

@implementation HotWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *leftbar = [[UIBarButtonItem alloc] initWithTitle:@"〈" style:UIBarButtonItemStyleDone target:self action:@selector(leftbarAction)];
    leftbar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftbar;
    self.title = @"热门微博";
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@". . ." style:UIBarButtonItemStyleDone target:self action:@selector(rightbarAction)];
    rightBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 30)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteview];
    
    //TopScroll视图显示具体标签
    self.topScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    self.topScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topScroll];
    
    //btnAddorDelete添加删除具体标签和视图
    self.btnAddorDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnAddorDelete setTitle:@"▽" forState:UIControlStateNormal];
    [self.btnAddorDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnAddorDelete.frame = CGRectMake(CGRectGetMaxX(self.topScroll.frame)+5, 65, 30, 30);
    [self.btnAddorDelete addTarget:self action:@selector(btnAddorDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnAddorDelete];
    
    //bodyScroll显示具体内容
    self.bodyScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScroll.frame)+10, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - (CGRectGetMaxY(self.topScroll.frame)+10))];
    self.bodyScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bodyScroll];
    
}

//返回按钮触发事件
- (void)leftbarAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.delegate.searchBar.hidden = NO;
}

//分享按钮触发事件
- (void)rightbarAction
{
    
}

- (void)btnAddorDeleteAction:(UIButton *)button
{
    HotWeiboCatalogueView *hotWeiboCalalogue = [[HotWeiboCatalogueView alloc] init];
    hotWeiboCalalogue.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 65);
    [self.view addSubview:hotWeiboCalalogue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
