//
//  Find_SearchView.m
//  WeiboFind
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "Find_SearchView.h"

#define row 5
#define line 2

@implementation Find_SearchView

//初始化视图方法
- (void)initWithFind_SearchViewWithDictionary:(NSDictionary *)dic
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    NSArray *ARR = @[@[@"11",@"12"],
                     @[@"21",@"22"],
                     @[@"31",@"32"],
                     @[@"41",@"42"],
                     @[@"51",@"52"]];
    NSArray *allButtonText = [dic allKeys];
    //热门话题
    int z = 0;
    for(int i = 1 ; i <= row ; i++){
        for (int y = 1; y <= line; y++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:allButtonText[z] forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake((y-1) * [UIScreen mainScreen].bounds.size.width/2+1,64+20+31*(i-1), [UIScreen mainScreen].bounds.size.width/2 - 1, 30);
            button.tag = [ARR[i-1][y-1] intValue];
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            z++;
        }
    }
}

- (void)btnAction:(UIButton *)button
{
    
}

- (void)initWithFind_SearchView2WithDictionary:(NSDictionary *)dic
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    self.searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    self.searchTable.delegate = self;
    self.searchTable.dataSource = self;
    [self addSubview:self.searchTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenStr = @"searchCell";
    UITableViewCell *searchcell = [tableView dequeueReusableCellWithIdentifier:idenStr];
    if (!searchcell) {
        searchcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenStr];
    }
    searchcell.textLabel.text = @"搜索";
    return searchcell;
}

//滚动UITableView时SearchBar取消第一响应者
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
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

@end
