//
//  ViewController.m
//  UI_0.5
//
//  Created by LXF on 15/9/30.
//  Copyright © 2015年 LXF. All rights reserved.
//

#import "CommentPageController.h"
#import "CM_Comment.h"
#import "CommentTableViewCell.h"

#import "WBRequestManager.h"
#import "WBCellController.h"

#define Height self.view.frame.size.height
#define Width self.view.frame.size.width
@interface CommentPageController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView* _tableView;
    NSArray* m_arr;
    NSString* _number;
    
    WBCellController* _theWBCellController;
}

@end

@implementation CommentPageController
-(id)initWithNumber:(NSString *)number
{
    if (self=[super init]) {
        _number=number;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWBCellController];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.title=@"微博正文";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, Width, Height-40) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [self data];
    [self btnAction];
    
}
-(void)btnAction{
    NSArray* arr=[[NSArray alloc]initWithObjects:@"转发",@"评论",@"赞", nil];
    for (int i=0; i<3; i++) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(Width/3*i, Height-40, Width/3, 40)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag=100+i;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
-(void)tabBarAction:(UIButton*)btn{
    NSLog(@"%ld",btn.tag-100);
}
-(void)data{
    CM_Comment* data=[CM_Comment new];
    m_arr=[data dicComment:_number];
}

-(void)initWBCellController
{
    WBStatus* status = [[WBRequestManager manager]statusWithID:_number];
    _theWBCellController = [[WBCellController alloc]initWithStatus:status];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else  return m_arr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* returnCell = nil;
    if ([indexPath section] == 0) {
        WBContainCell* wbCell =
        [[WBContainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [_theWBCellController constructCell:wbCell];
        returnCell = wbCell;
    }
    if (indexPath.section==1) {
        CommentTableViewCell* cell;
        cell=[[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        NSDictionary*dic=m_arr[indexPath.row];
        [cell dicWithComment:dic];
        returnCell = cell;
    }
    return returnCell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger heightOfCell = 0;
    if (indexPath.section==1) {
       CommentTableViewCell* cell=[[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        NSDictionary*dic=m_arr[indexPath.row];
        [cell dicWithComment:dic];
        heightOfCell = cell.height;
    }else if (indexPath.section==0) {
        heightOfCell = _theWBCellController.heightOfCell;
    }
    return heightOfCell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view;
    NSArray* arr=[[NSArray alloc]initWithObjects:@"转发",@"评论",@"赞", nil];
    if (section==1) {
        view=[[UIView alloc]init];
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, Width, 1)];
        lable.backgroundColor=[UIColor lightGrayColor];
        lable.alpha=0.5;
        view.backgroundColor=[UIColor whiteColor];
        [view addSubview:lable];
        UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(Width/6, 40-3, Width/6, 3)];
        lable1.backgroundColor=[UIColor orangeColor];
        [view addSubview:lable1];
        
        for (int i=0; i<2; i++) {
            UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(Width/6*i, 0, Width/6, 40)];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=100+i;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        
        return view;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 40;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 0;
    }
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

