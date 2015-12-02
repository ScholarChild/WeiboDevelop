//
//  ToViewController.m
//  微博开发1
//
//  Created by Ibokan on 15/11/23.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "MessagePageController.h"
#import "ToCommentViewController.h"
#import "ToAtViewController.h"
#import "ToGoodViewController.h"
#import "ToMessageboxViewController.h"
#import "ToSubscriptionViewController.h"
#import "ToConnet.h"
#import "SearchViewController.h"
#import "ToConnet.h"
#import "FlocksViewController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface MessagePageController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _imgarr;//储存图片数组
    NSMutableArray* _textarr;//储存文字数组
    
    UISearchBar *_searchBar;
    NSArray* arr;
}

@end

@implementation MessagePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f,",Height/2);
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.edgesForExtendedLayout=UIRectEdgeNone;
    self.title=@"消息";
    UIBarButtonItem* leftBar=[[UIBarButtonItem alloc]initWithTitle:@"发现群" style:UIBarButtonItemStylePlain  target:self action:@selector(leftAction)];
    leftBar.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=leftBar;
    UIBarButtonItem* rightBar=[[UIBarButtonItem alloc]initWithTitle:@"聊天" style:UIBarButtonItemStylePlain  target:self action:@selector(rightAction)];
    rightBar.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem=rightBar;
    
//    [self performSelectorOnMainThread:@selector(viewAction) withObject:nil waitUntilDone:YES];
//    [self performSelector:@selector(date)];
    
    [self viewAction];//视图加载
//
//    
    
    //数据加载
    //待改进
    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(dateAction) userInfo:nil repeats:NO];
}

#pragma mark 当前视图
-(void)viewAction{
    //搜索框
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,69, Width, 30)];
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    _searchBar.placeholder=@"搜索联系人和群";
    [self.view addSubview:_searchBar];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,94+10, Width, Height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _textarr=[[NSMutableArray alloc]initWithObjects:@"@我的",@"评论",@"赞",@"订阅消息",@"未关注人消息", nil];
    _imgarr=[[NSMutableArray alloc]initWithObjects:@"messagescenter_at.png",@"messagescenter_comments.png",@"messagescenter_good.png",@"messagescenter_subscription.png",@"messagescenter_messagebox.png", nil];

}
-(void)dateAction{
    arr=[ToConnet allConnet];
    
}
#pragma mark -----------------tebleView的代理方法开始----------------------------
//多少段
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _textarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
   
    cell.textLabel.text=[_textarr objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[_imgarr objectAtIndex:indexPath.row]];
    return cell;
    
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//页眉多长
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
//点击tableView触发
#pragma mark 待改进
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        ToAtViewController* toAt=[ToAtViewController new];
        toAt.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:toAt animated:YES];
    }
    
    if (indexPath.row==1) {
    ToCommentViewController* toCommet=[ToCommentViewController new];
    toCommet.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:toCommet animated:YES];
    }
    
    if (indexPath.row==2) {
    ToGoodViewController* toGood=[ToGoodViewController new];
    toGood.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:toGood animated:YES];
    }
    
    if (indexPath.row==3) {
    ToMessageboxViewController* toMess=[ToMessageboxViewController new];
    toMess.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:toMess animated:YES];
    }
    
    if (indexPath.row==4) {
    ToSubscriptionViewController* toSub=[ToSubscriptionViewController new];
    toSub.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:toSub animated:YES];
    }
}
#pragma mark -----------------tebleView的代理方法结束----------------------------




#pragma mark 点击搜索框触发  页面跳转
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"开始");
    SearchViewController *controller =[[SearchViewController alloc]initName:arr];
       controller.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [controller.searchController.searchBar becomeFirstResponder];
    
    [self presentViewController:controller animated:YES completion:nil];
    return NO;
}



#pragma mark -----------------左右按钮-----------------
-(void)leftAction{
    FlocksViewController* flocks=[FlocksViewController new];
    flocks.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:flocks animated:YES];
}
-(void)rightAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
