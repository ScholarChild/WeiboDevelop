//
//  SearchViewController.m
//  微博开发1
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "SearchViewController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
#import "ToConnet.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
{
    UITableView* _tableView;
   
    
    UISearchController* _searchCV;
    
}
@property (strong,nonatomic) NSArray *dataList;

@property (strong,nonatomic) NSMutableArray *searchList;


@end
@implementation SearchViewController
-(id)initName:(NSArray *)arr
{
    if (self=[super init]) {
        self.searchList=[NSMutableArray new];
        self.dataList=arr;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self data];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 22, Width,Height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;//搜索的时候是否显示背景，NO是显示，默认为YES
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
   
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder=@"搜索联系人和群";
    //tableView绑定searchBar
    _tableView.tableHeaderView = self.searchController.searchBar;
    
     _searchController.searchBar.returnKeyType=UIReturnKeyDone;//设置键盘返回键样式
    
    //待改进
//    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
    self.view.alpha=0.8;
    
}
-(void)becomAction;{
    [_searchController.searchBar becomeFirstResponder];

}
-(void)animationAction{
    [UIView beginAnimations:@"ShowView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
  
    self.view.alpha=0.9;
  
    
    
}
//这里采用笨方法(用定时器设置进去的时候是点击状态的)待改进
-(void)timerAction{
    [_searchController.searchBar becomeFirstResponder];
}
//获取数据
-(void)data{
    
    //获取网络上关注的数据
 
  
}


#pragma mark ----------------tableView的代理方法开始-------------------------
//分几段
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
//每段的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
    }
    //显示搜索到的数据
    if (self.searchController.active) {
        NSDictionary* dic=self.searchList[indexPath.row];
        //图片需要从网络上获取
        NSString* string=[dic objectForKey:@"avatar_hd"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
        UIImage *image =[ UIImage imageWithData:data];
        [cell.textLabel setText:[dic objectForKey:@"name"]];
        cell.imageView.image=image;

    }
    //显示要搜索的全部数据(这里没显示的原因是上面每段行数设置为0)
    else{
        NSDictionary* dic=self.dataList[indexPath.row];
         [cell.textLabel setText:[dic objectForKey:@"name"]];
        //图片需要从网络上获取
        NSString* string=[dic objectForKey:@"avatar_hd"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
        UIImage *image =[ UIImage imageWithData:data];
        cell.imageView.image=image;
        
    }
    return cell;
    
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark ----------------tableView的代理方法结束-------------------------

#pragma mark SearchController代理方法 搜索方法
/*
 根据搜索框的值搜索出与之相关的信息,搜索出的信息是array里面包含着数个字典，字典里面是name值跟头像
 1.先清除self.searchList里面的数据
 2.//获取self.dataList里面的name值
 3.挑出跟搜索框相同原素的值，储存在self.searchList
 4.得到self.searchList挑出来的name值
 5.self.searchList里面的值跟self.dataList里面的name值一一比对，将name值对应的图片配对出来
 6.将存有name属性跟图片属性的字典传进self.searchList
 */
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    //谓词搜索
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchString];
    // 过滤数据
    if (self.searchList!= nil) {//先清除self.searchList里面的数据
        [self.searchList removeAllObjects];
    }
    NSMutableArray* mArr=[NSMutableArray new];

    for (int i=0;i<self.dataList.count;i++) {
        NSDictionary* dic=self.dataList[i];
        NSString* name=[dic objectForKey:@"name"];
        [mArr addObject:name];//获取self.dataList里面的name值
    }
    self.searchList= [NSMutableArray arrayWithArray:[mArr filteredArrayUsingPredicate:preicate]];//挑出跟搜索框相同原素的值
    NSLog(@"marr:%@",self.searchList);
    [mArr removeAllObjects];//移除mArr里面的值，因为下面还需要用到
    
    
    for (int i=0;i<self.searchList.count;i++) {
        for (int j=0; j<self.dataList.count; j++) {
             NSDictionary* dic=self.dataList[j];
            NSString* name=[dic objectForKey:@"name"];//得到self.searchList挑出来的name值
            if([self.searchList[i] isEqualToString:name]){//一一比对，目的是将name值对应的图片配对出来
                [mArr addObject:dic];
              
            }
        }
    }
    
    [self.searchList removeAllObjects];
    self.searchList=mArr;//将存有name属性跟图片属性的字典传进self.searchList
  
    [_tableView reloadData];//刷新视图

}

#pragma mark -------------------searchBar的代理方法----------------------------------
//开始编辑按钮
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
//点击返回按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}
//点击取消按钮
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
