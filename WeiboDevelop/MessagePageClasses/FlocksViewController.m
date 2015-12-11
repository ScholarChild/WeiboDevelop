//
//  FlocksViewController.m
//  微博开发1
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "FlocksViewController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface FlocksViewController ()<UIScrollViewDelegate>
{
    UIView* view;
    UIScrollView* scrollView;
    int mytag;
}
@end

@implementation FlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
#pragma mark 改页面
 //页面跳转使用模态跳转,自定义navigationBar
    UINavigationBar* bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20,self.view.frame.size.width, 44)];//定义一个NavigationBar，距离屏幕20，一个屏幕宽，44高度
    UINavigationItem* item=[[UINavigationItem alloc]initWithTitle:@"标题"];
    UIBarButtonItem* leftBar=[[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStylePlain  target:self action:@selector(leftAction)];
    item.leftBarButtonItem=leftBar;
    [bar pushNavigationItem:item animated:NO];//设置好BarButtonItem之后将Item绑定到Bar中
    [self.view addSubview:bar];
    
    
    
    view=[[UIView alloc]init];
   
    view.backgroundColor=[UIColor orangeColor];
    
    view.frame=CGRectMake(0,28, Width/5, 2);
    
    
    self.title=@"发现群" ;
    NSArray* arr=[[NSArray alloc]initWithObjects:@"首页",@"名人明星",@"影视综艺",@"动漫游戏",@"投资理财",@"行业交流",@"女性时尚",@"体育运动",@"情感交流",@"生活", nil];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, 30)];
    scrollView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    scrollView.contentSize=CGSizeMake(Width*2, 0);
    scrollView.delegate=self;
    scrollView.bounces=NO;
    
    scrollView.showsHorizontalScrollIndicator=NO;
    //滚动时是否显示垂直滚动条
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    [scrollView addSubview:view];
    for (int i=0; i<arr.count ; i++) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(i*Width/5,0, Width/5, 30)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont fontWithName:@"" size:7];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        btn.tag=1000+i;
        if (i==0) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
    }
    mytag=1000;
    scrollView.contentSize=CGSizeMake(Width*2, 0);
    
}
-(void)btnAction:(UIButton*)btn{
    UIButton* temp=(UIButton*)[self.view viewWithTag:mytag];
    [temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mytag=(int)btn.tag;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    view.frame=CGRectMake(btn.frame.origin.x,28, Width/5, 2);
    scrollView.contentSize=CGSizeMake(Width*2, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    CGPoint point = scrollView1.contentOffset;
    // 限制y轴不动
//    point.y = 0.f;
    scrollView1.contentOffset = point;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftAction{
    [self dismissViewControllerAnimated:NO completion:nil];
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
