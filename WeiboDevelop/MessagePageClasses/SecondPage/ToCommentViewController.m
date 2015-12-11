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



@interface ToCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView* _tableView;
    NSArray* m_arr;
    NSMutableArray* imgArr1;
    NSMutableArray* imgArr2;
}

@end

@implementation ToCommentViewController
-(id)initWithNumber:(NSString *)number
{
    if (self=[super init]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    [self data];
}
-(void)data{
    CM_CommentData* data=[[CM_CommentData alloc]init];
    m_arr=[data dicCommentData];
    imgArr1=[NSMutableArray new];
    imgArr2=[NSMutableArray new];
    
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
    NSDictionary*dic=m_arr[indexPath.row];
    [cell arrayTableViewCell:dic endIma:imgArr1[indexPath.row] endImage:imgArr2[indexPath.row]];
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

