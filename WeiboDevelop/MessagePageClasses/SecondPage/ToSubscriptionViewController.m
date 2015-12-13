//
//  ToSubscriptionViewController.m
//  微博开发1
//
//  Created by Ibokan on 15/11/24.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "ToSubscriptionViewController.h"
#import "EmoticonsView.h"
#define Height self.view.frame.size.height
#define Width self.view.frame.size.width
#define viewH 200
#define textX 10

@interface ToSubscriptionViewController ()<UITextViewDelegate,UIScrollViewDelegate>
{
    UITextView* _textView;
    UILabel*  _label;
    UIToolbar* toolbar;
    NSString* textViewString;
    
    UIScrollView* _scrollView;
    UIPageControl* _pageControl;
    
    UINavigationBar* bar;
    UINavigationItem*item;
}
@end

@implementation ToSubscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发微博";
    UIBarButtonItem* rightbar=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(barButton)];
    self.navigationItem.rightBarButtonItem=rightbar;
    UIBarButtonItem* lebar=[[UIBarButtonItem alloc]initWithTitle:@"<-" style:UIBarButtonItemStyleDone target:self action:@selector(letBar)];
    
    self.navigationItem.leftBarButtonItem=lebar;
    bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 22, Width, 40)];
//    bar.items=@[@"aaa",@"aaa"];
     item=[[UINavigationItem alloc]initWithTitle:@"发微博"];
    
    [bar pushNavigationItem:item animated:NO];
    
    
    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(textX+6, 66+5, 100, 30)];
    _label.textColor=[UIColor lightGrayColor];
    _label.text=@"分享新鲜事...";
    _label.font=[UIFont systemFontOfSize:20];
    
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(textX, 66, Width-2*textX, Height/2)];
    _textView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:_textView ];
    _textView.font=[UIFont systemFontOfSize:20];
    _textView.delegate=self;
    _textView.scrollEnabled = NO;//不能移动
    _textView.returnKeyType=UIReturnKeyDefault;//返回键
    _textView.keyboardType=UIKeyboardTypeDefault;//键盘类型
    [_textView becomeFirstResponder];
    
    [self.view addSubview:_label];
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, Height-44, Width, 44)];
    for (int i=0; i<5; i++) {
        NSString* imgString=[NSString stringWithFormat:@"face%d.png",i];
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(Width/5*i, 0, 60, 40)];
        [btn setImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [toolbar addSubview:btn];
        
        [self.view addSubview:toolbar];
    }
    textViewString=@"";//储存textView的文本
    //scrollView和分页的添加
    [self scrollViewPage];
    [self.view addSubview:bar];
    [self BtnActions];
}
-(void)BtnActions{
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [btn setTitle:@"后退" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(letBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)letBar{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}
//文本换表情
#pragma mark 文本转换表情
-(void)ceshi:(NSString*)str{
    textViewString=str;
    [_label setHidden:YES];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    //加载plist文件中的数据
    NSBundle* boule=[NSBundle mainBundle];
    NSString* path=[boule pathForResource:@"comEn" ofType:@"plist"];
    NSDictionary * dic=[[NSDictionary alloc]initWithContentsOfFile:path];
    //获取plist中的数据
    NSArray *face = [dic objectForKey:@"emoticons"];
    //正则匹配要替换的文字的范围
    //正则表达式
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    //通过正则表达式来匹配字符串
    NSArray *resultArray = [re matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        
        //获取原字符串中对应的值
        NSString *subStr = [str substringWithRange:range];
        
        for (int i = 0; i < face.count; i ++)
        {
            if ([face[i][@"chs"] isEqualToString:subStr])
            {
                
                //face[i][@"gif"]就是我们要加载的图片
                //新建文字附件来存放我们的图片
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:face[i][@"png"]];
                textAttachment.bounds = CGRectMake(0, 0, 20, 20);
                
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                
                //把字典存入数组中
                [imageArray addObject:imageDic];
                
            }
        }
    }
    //从后往前替换
    for (int i = (int)imageArray.count -1; i >= 0; i--)
    {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    
   
    _textView.attributedText = attributeString;
    _textView.font=[UIFont systemFontOfSize:20];
}
#pragma mark scrollView与pageControl添加方法
-(void)scrollViewPage
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height, 0, 0)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(Width*4, viewH)];
    //_scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.pagingEnabled = YES;
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    for (int i=0; i<4; i++) {
        EmoticonsView * view1 = [[EmoticonsView alloc]initWithNumber:i endBlock:^(NSString* text){
            textViewString=[textViewString stringByAppendingString:text];
            [self ceshi:textViewString];
        }];
        view1.frame=CGRectMake(Width*i, 0, Width, viewH);
        [_scrollView addSubview:view1];
    }
    [self.view addSubview:_scrollView];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, Height, 0, 0)];
    _pageControl.center = CGPointMake(Width/2, Height-20);
    _pageControl.numberOfPages = 4;
    _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
}
#pragma mark 点击表情图片
-(void)btnAction:(UIButton*)btn{
    if (btn.tag==103) {
        [_textView resignFirstResponder];
        toolbar.frame=CGRectMake(0, Height-44-200, Width,44);
        _scrollView.frame=CGRectMake(0, Height-viewH, Width, viewH);
        _pageControl.frame=CGRectMake(0, 0, 200, 20);
        _pageControl.center = CGPointMake(Width/2, Height-20);
    }
}
#pragma mark 分页
-(void)pageChanged:(UIPageControl*)page
{
    int p = (int)page.currentPage;
    [_scrollView scrollRectToVisible:CGRectMake(Width*p, 0, Width, viewH) animated:YES];
}
#pragma mark scrollView分页
-(void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGFloat pageWith = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    _pageControl.currentPage = page;
}


#pragma mark 开始触发textView方法
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        toolbar.frame=CGRectMake(0, 374,Width, 44);
        _scrollView.frame=CGRectMake(0, Height, 0, 0);
        _pageControl.frame=CGRectMake(0, Height, 0, 0);
        
    }];
    if(![_textView.text isEqualToString:@""]){
        [_label setHidden:YES];
        
    }
    return YES;
}
#pragma mark 结束触发textView方法
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    toolbar.frame=CGRectMake(0, Height-44, Width,44);
    _scrollView.frame=CGRectMake(0, Height, 0, 0);
    _pageControl.frame=CGRectMake(0, Height, 0, 0);
    return YES;
}
//通过判断表层TextView的内容来实现底层TextView的显示于隐藏
#pragma mark 修改文本时textView文本

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    textViewString=[textViewString stringByAppendingString:text];
    
    if(![text isEqualToString:@""])
    {
        [_label setHidden:YES];
    }
    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
        [_label setHidden:NO];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSLog(@"1text:%@",text);
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"2text:%@",textView.text);
    
}
-(void)textViewDidChangeSelection:(UITextView *)textView
{
//    NSLog(@"3");
    NSLog(@"3text:%@:",textView.text);
    NSLog(@"%@",textViewString);
}


-(void)show{
    UINavigationController*navi=[[UINavigationController alloc]initWithRootViewController:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:navi.visibleViewController.view];
    [window.rootViewController addChildViewController:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
