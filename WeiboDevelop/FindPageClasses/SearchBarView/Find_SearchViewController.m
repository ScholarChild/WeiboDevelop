//
//  Find_SearchViewController.m
//  WeiboFind
//
//  Created by ibokan on 15/11/24.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "Find_SearchViewController.h"

@interface Find_SearchViewController ()

@end

@implementation Find_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];

    self.searchView = [[Find_SearchView alloc] init];
    self.searchView.delegate = self.delegate;
    self.searchView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.searchView];
    [self initWithFind_SearchView];
}

- (void)initWithFind_SearchView
{
    self.searchModal = [[Find_SearchModal alloc] init];
    NSDictionary *buttondic = nil;
    
    [self.searchModal initWithButtonDictionary:buttondic];
    [self.searchView initWithFind_SearchViewWithDictionary:self.searchModal.buttondic];
}

- (void)initWithFind_SearchView2
{
    self.searchModal = [[Find_SearchModal alloc] init];
    NSDictionary *tableviewdic = nil;
    
    [self.searchModal initWithTableViewDictionary:tableviewdic];
    [self.searchView initWithFind_SearchView2WithDictionary:self.searchModal.tableviewdic];
}

//点击屏幕时searchBar取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate.searchBar resignFirstResponder];
    for(id btn in [self.delegate.searchBar.subviews[0] subviews])
    {
        if([btn isKindOfClass:[UIButton class]])
        {
            UIButton *cancelbtn = (UIButton *)btn;
            cancelbtn.enabled = YES;
            break;
        }
    }
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
