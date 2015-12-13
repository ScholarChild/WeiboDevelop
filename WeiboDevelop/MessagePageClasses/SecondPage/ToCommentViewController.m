//
//  ToCommentViewController.m
//  微博开发1
//
//  Created by Ibokan on 15/11/24.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "ToCommentViewController.h"
#import "CM_CommentData.h"
#import "CommentToMyTableViewCell.h"
#define Height self.view.frame.size.height
#define Width self.view.frame.size.width
#import "AFHTTPSessionManager.h"


@interface ToCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView* _tableView;
    NSArray* m_arr;
    NSMutableArray* imgArr1;
    NSMutableArray* imgArr2;
    BOOL Arrnil;
}

@end

@implementation ToCommentViewController
-(id)initWithArr:(NSArray*)arr
{
    if (self=[super init]) {
        m_arr=arr;
        Arrnil=NO;
        
    }
    return self;
}
-(void)commentAction{
    
    NSString* str=[NSString stringWithFormat:@"https://api.weibo.com/2/comments/to_me.json?source=1626555808&access_token=%@",access_token ];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:str parameters:nil success:^(NSURLSessionDataTask* task ,id responseObeject){
        //        CM_ToMy_data* data=[CM_ToMy_data mj_objectWithKeyValues:dataDit];
        
        NSArray* C_arr=[responseObeject objectForKey:@"comments"];
        CM_CommentData* commen=[CM_CommentData new];
        m_arr=[commen dicCommentData:C_arr];
        [self data];
        NSLog(@"评论获取成功");
    }failure:^(NSURLSessionDataTask* task ,NSError* error){
        NSLog(@"获取失败");
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    imgArr1=[NSMutableArray new];
    imgArr2=[NSMutableArray new];
    if (m_arr==nil) {
        [self commentAction];
        Arrnil=YES;
    }

    [self data];
}
-(void)data{
//    CM_CommentData* data=[[CM_CommentData alloc]init];
//    m_arr=[data dicCommentData];
    
  

    for (NSDictionary *dic in m_arr) {
        NSString* string=[dic objectForKey:@"comment.user.profile_image_url"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
        UIImage *image =[ UIImage imageWithData:data];
        [imgArr1 addObject:image];
        NSString* string1=[dic objectForKey:@"comment.status.user.profile_image_url"];
        NSData * data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:string1]];
        UIImage *image1 =[ UIImage imageWithData:data1];
        [imgArr2 addObject:image1];
    }
    if (Arrnil) {
        [_tableView reloadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return m_arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentToMyTableViewCell* cell;
    static NSString* CellIndentifier=@"CellIndentifier";
    if(!cell){
        cell=[[CommentToMyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
    }
    
    [cell arrayTableViewCell:m_arr[indexPath.section] endIma:imgArr1[indexPath.section] endImage:imgArr2[indexPath.section] ];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentToMyTableViewCell* cell;
    if(!cell){
        cell=[[CommentToMyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIndentifier"];
    }
    NSDictionary*dic=m_arr[indexPath.section];
    [cell arrayTableViewCell:dic endIma:imgArr1[indexPath.section] endImage:imgArr2[indexPath.section]];
    return cell.heightY;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

