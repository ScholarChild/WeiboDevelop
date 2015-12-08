//
//  FindViewController.m
//  WeiboFind
//
//  Created by ibokan on 15/11/23.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "FindViewController.h"
#import "Find_SearchViewController.h"

#import "FindModal.h"
#import "HotWeiboViewController.h"

#import "DataManager.h"

#import "FindPageTableViewCell.h"
#import "UserInfoTableView.h"


@interface FindViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL isPush;   //判断是否被推出
    Find_SearchViewController *search;
    ////////////
    
    UserInfoTableView *_tableview;
    NSMutableArray *_dataArr;
    
}
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化
    isPush = NO;
    
    
    //构建模型
    FindModal *findModal = [[FindModal alloc] init];
    [findModal initWithSearchBarWithPlaceholder:@"雨中一奇葩"];
    
    //语音按钮
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setBackgroundImage:[UIImage imageNamed:@"message_voice_background@2x.png"] forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 0, 30, 30);
    [self.button addTarget:self action:@selector(BtnTalk) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *talkbar = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    self.navigationItem.rightBarButtonItem = talkbar;
   
    //SearchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, -10, CGRectGetMinX(self.button.frame)-20, 64)];
    NSString *str = @"大家都在搜:";
    str = [str stringByAppendingString:findModal.searchbarplaceholder];
    self.searchBar.placeholder = str;
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchDC = [[UISearchController alloc] initWithSearchResultsController:self];
    [self.navigationController.navigationBar addSubview:self.searchBar];

    [self initTableView];
}

//监听说话按钮
- (void)BtnTalk
{
    
}


//SearchBar被文本改变时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchBarTextDidBeginEditing:searchBar];
}

//更改默认导航栏调用方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //更改导航栏
    self.searchBar.showsCancelButton = YES;
    self.searchBar.showsSearchResultsButton = YES;
    self.button.hidden = YES;
    self.searchBar.frame = CGRectMake(10, -10, [UIScreen mainScreen].bounds.size.width - 10, 64);
    for(id btn in [searchBar.subviews[0] subviews])
    {
        if([btn isKindOfClass:[UIButton class]])
        {
            UIButton *cancelbtn = (UIButton *)btn;
            [cancelbtn setTitle:@"取消"  forState:UIControlStateNormal];
            [cancelbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        }
    }
    //推出视图
    if (isPush == NO) {
        search = [[Find_SearchViewController alloc] init];
        search.delegate = self;
        CATransition *transition = [self setCATransition];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:search animated:YES];
        isPush = YES;
    }
    //当searchBar文本不为空的时候更换视图
    if (![searchBar.text isEqualToString:@""]) {
        [search initWithFind_SearchView2];
    }
    else
    {
        [search initWithFind_SearchView];
    }
}

//点击SearchBarResultsListButton按钮
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2)
{

}

//监听键盘搜索键
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [searchBar resignFirstResponder];
        //设置cancelbtn能够被响应
        for(id btn in [searchBar.subviews[0] subviews])
        {
            if([btn isKindOfClass:[UIButton class]])
            {
                UIButton *cancelbtn = (UIButton *)btn;
                cancelbtn.enabled = YES;
                break;
            }
        }
//        CATransition *transition = [self setCATransition];
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isPush = NO;
    //更改导航栏
    self.searchBar.showsCancelButton = NO;
    self.searchBar.showsSearchResultsButton = NO;
    self.button.hidden = NO;
    self.searchBar.frame = CGRectMake(10, -10, CGRectGetMinX(self.button.frame)-20, 64);
    self.searchBar.text = nil;
    [searchBar resignFirstResponder];
    //移除视图
    CATransition *transition = [self setCATransition];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//改变视图间切换动画
- (CATransition *)setCATransition
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFade;
    transition.delegate = self;
    return transition;
}


#pragma mark Tableview

- (void)initTableView
{
    _dataArr = [NSMutableArray arrayWithArray:[DataManager getPlistDataWithName:@"FindPageInfo"]];
    _tableview = [[UserInfoTableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-114) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.delaysContentTouches = NO;
    for (UIView *currentView in _tableview.subviews) {
        if([currentView isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }  
    }
    [self.view addSubview:_tableview];}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindPageTableViewCell*cell = [[FindPageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary * dic = [[_dataArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            
            [cell initHeadSubviews];
            cell.headDataDic = dic;
            
        }
    }
    else if(indexPath.section == 1)
    {
        [cell initNeckSubviews];
        cell.neckDataDic = dic;
        
    }
    else
    {
        [cell initBodySubviews];
        cell.dataDic = dic;
        
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = [_dataArr objectAtIndex:section];
    return arr.count;
}

//section头部间距  不设=默认值
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0 ||indexPath.section ==1)
    {
        return 80;
    }
    
    return  40;
}


//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}


// label.text的数据和push 页面的数据是统一的
- (void)findPagePushNews:(UIButton*) clickedBtn
{
    NSString* title =  clickedBtn.titleLabel.text;
    NSLog(@"%s ,%@",__func__,title);
    
}

- (void)adPushAction:(UIGestureRecognizer *)tap
{
    if ([tap.view isMemberOfClass:[UIImageView class]] ) {
        NSLog(@"dd,%@",tap.view);
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    NSArray *aroundInfoArr = [DataManager getPlistDataWithName:@"Arround"];
    int value = arc4random() % 4;
    NSString *str = [aroundInfoArr objectAtIndex:value];
    NSMutableArray * dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FindPageInfo" ofType:@"plist"]];
    NSMutableArray *SectionArr = [dataArr objectAtIndex:3];
    NSMutableDictionary *rowDic = [SectionArr objectAtIndex:2];
    [rowDic setValue:str forKey:@"detail"];
    [SectionArr replaceObjectAtIndex:2 withObject:rowDic];
    [dataArr replaceObjectAtIndex:3 withObject:SectionArr];
    //    [dataArr writeToFile:[[NSBundle mainBundle] pathForResource:@"FindPageInfo" ofType:@"plist"] atomically:YES];
    
    [_dataArr replaceObjectAtIndex:3 withObject:SectionArr];
}

#pragma mrak - 添加部分二级界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
        HotWeiboViewController *hotWeibo = [[HotWeiboViewController alloc] init];
        hotWeibo.delegate = self;
        self.searchBar.hidden = YES;
        [self.navigationController pushViewController:hotWeibo animated:YES];
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
