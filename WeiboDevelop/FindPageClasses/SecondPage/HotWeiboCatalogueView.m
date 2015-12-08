//
//  HotWeiboCatalogueView.m
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "HotWeiboCatalogueView.h"
#import "DeletePoint.h"

#define line 4
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation HotWeiboCatalogueView

- (instancetype)init
{
    if (self = [super init]) {
        
        //初始化数据
        personalArray = [NSMutableArray arrayWithArray:@[@"推荐",@"榜单",@"珠海",@"视频",
                                                         @"社会",@"动漫",@"音乐",@"科技",
                                                         @"教育",@"汽车",@"综艺",@"美妆",
                                                         @"读书",@"科普"]];
        addArray = [NSMutableArray arrayWithArray:@[@"看点",@"国际",@"数码",@"财经",
                                                    @"股市",@"明星",@"电视剧",@"电影",
                                                    @"体育",@"运动健身",@"健康",@"瘦身",
                                                    @"养生",@"军事",@"历史",@"美女模特",
                                                    @"美图",@"自媒体",@"情感",@"语录",
                                                    @"辟谣",@"正能量",@"政务",@"美女游戏",
                                                    @"旅游",@"育儿",@"美食",@"房产",
                                                    @"家居",@"星座",@"三农",@"设计",
                                                    @"艺术",@"时尚",@"宗教",@"神最右",
                                                    @"萌宠",@"随便看看",@"笑话"]];
        
        
        self.whiteview = [[UIView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 30)];
        self.whiteview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteview];
        
        //我的分类UILable
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        [label setText:@"我的分类"];
        label.font = [UIFont fontWithName:@"Arial" size:15];
        [self.whiteview addSubview:label];
        
        //btnAddorDelete按钮
        UIButton *btnAddorDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnAddorDelete setTitle:@"△" forState:UIControlStateNormal];
        [btnAddorDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnAddorDelete.frame = CGRectMake(WIDTH - 40, 0, 30, 30);
        [btnAddorDelete addTarget:self action:@selector(btnAddorDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteview addSubview:btnAddorDelete];
        
        //编辑按钮
        self.editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.editBtn.frame = CGRectMake(CGRectGetMinX(btnAddorDelete.frame) - 60, 5, 50, 20);
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTintColor:[UIColor orangeColor]];
        [self.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.editBtn.layer.borderWidth = 1;
        self.editBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        self.editBtn.layer.cornerRadius = 10;
        [self.whiteview addSubview:self.editBtn];
        
        //bodyScroll显示具体内容
        self.bodyScroll = [[UIScrollView alloc] init];
        self.bodyScroll.frame = CGRectMake(0, CGRectGetMaxY(self.whiteview.frame)+1, WIDTH,0);
        self.bodyScroll.delaysContentTouches = NO;
        self.bodyScroll.bounces = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.bodyScroll.frame = CGRectMake(0, CGRectGetMaxY(self.whiteview.frame)+1, WIDTH,HEIGHT - (CGRectGetMaxY(self.whiteview.frame)+1));
        [UIView commitAnimations];
        self.bodyScroll.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self addSubview:self.bodyScroll];
        
        //我的分类视图
        self.personalCatalogueView = [[UIView alloc] init];
        self.personalCatalogueView.userInteractionEnabled = NO;
        [self initWithPersonalCatalogue];
        
        //点击添加分类
        self.addlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.personalCatalogueView.frame), WIDTH - 20, 30)];
        [self.addlabel setText:@"点击添加分类"];
        [self.addlabel setFont:[UIFont fontWithName:@"Arial" size:15]];
        [self.bodyScroll addSubview:self.addlabel];
        
        //添加分类视图
        self.addCalalogueView = [[UIView alloc] init];
        self.addCalalogueView.userInteractionEnabled = NO;
        [self initWithAddCalalogue];
        
    }
    return self;
}

#pragma mark - 初始化个人分类
- (void)initWithPersonalCatalogue
{
    NSInteger runNum = 1;
    CGFloat height = 0.0;
    NSInteger  Row = personalArray.count%line?personalArray.count/line + 1:personalArray.count/line;
    NSInteger Line = 4;
    for(int i = 1 ; i <= Row; i++){
        if (i == Row) {
            Line = personalArray.count%line;
            if(Line == 0)
            {
                Line = line;
            }
        }
        for (int y = 1; y <= Line; y++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:personalArray[runNum-1] forState:UIControlStateNormal];
            button.tag = runNum;
            [button setTintColor:[UIColor blackColor]];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake((y-1) * WIDTH/4+10,30*(i-1)+5*i, WIDTH/4 - 20, 30);
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.cornerRadius = 5;
            [button addTarget:self action:@selector(removePersonalAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.personalCatalogueView addSubview:button];
            if (button.tag == personalArray.count) {
                height = CGRectGetMaxY(button.frame);
            }else
            {
                runNum ++;
            }
        }
    }
    self.personalCatalogueView.frame = CGRectMake(0, 1, WIDTH, height+5);
    self.personalCatalogueView.backgroundColor = [UIColor whiteColor];
    [self.bodyScroll addSubview:self.personalCatalogueView];
    if(isEdit == YES)
    {
        isEdit = NO;
        [self editBtnAction];
    }
}

#pragma mark - 初始化添加页面
- (void)initWithAddCalalogue
{
    NSInteger runNum = 1;
    CGFloat height = 0.0;
    NSInteger  Row = addArray.count%line?addArray.count/line + 1:addArray.count/line;
    NSInteger Line = 4;
    
    for(int i = 1 ; i <= Row; i++){
        if (i == Row) {
            Line = addArray.count%line;
            if(Line == 0)
            {
                Line = line;
            }
        }
        for (int y = 1; y <= Line; y++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:addArray[runNum-1] forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake((y-1) * WIDTH/4+10,30*(i-1)+5*i, WIDTH/4 - 20, 30);
            button.layer.borderWidth = 1;
            button.tag = runNum;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.cornerRadius = 5;
            [button addTarget:self action:@selector(insertPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.addCalalogueView addSubview:button];
            if (button.tag == addArray.count) {
                height = CGRectGetMaxY(button.frame);
            }else
            {
                runNum ++;
            }
        }
    }
    self.addCalalogueView.frame = CGRectMake(0, CGRectGetMaxY(self.addlabel.frame), WIDTH, height+5);
    self.addCalalogueView.backgroundColor = [UIColor whiteColor];
    [self.bodyScroll addSubview:self.addCalalogueView];
    
      self.bodyScroll.contentSize = CGSizeMake(WIDTH,CGRectGetMaxY(self.addCalalogueView.frame)+50);
}

#pragma mark - 编辑按钮触发事件
- (void)editBtnAction
{
    if(isEdit == YES)
    {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        isEdit = NO;
        for (UIButton *btn in [self.personalCatalogueView subviews]) {
            NSLog(@"%@",[btn subviews]);
            for (DeletePoint *deletePoint in [btn subviews]) {
                if ([deletePoint isMemberOfClass:[DeletePoint class]]) {
                    [deletePoint removeFromSuperview];
                    self.personalCatalogueView.userInteractionEnabled = NO;
                    self.addCalalogueView.userInteractionEnabled = NO;
                }
            }
        }
    }
    else
    {
        [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        isEdit = YES;
        for (UIButton *btn in [self.personalCatalogueView subviews]) {
            DeletePoint *deletePoint = [[DeletePoint alloc] init];
            [btn addSubview:deletePoint];
            self.personalCatalogueView.userInteractionEnabled = YES;
            self.addCalalogueView.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - 点击个人分类按钮触发事件
- (void)removePersonalAction:(UIButton *)button
{
    //删除personalArray对应的数据
    NSInteger buttonTag = button.tag;
    NSLog(@"%ld",(long)buttonTag);
    NSString *str = [personalArray objectAtIndex:buttonTag - 1];
    NSLog(@"%@",str);
    [personalArray removeObjectAtIndex:buttonTag - 1];
    
    NSInteger subViewNums = [self.addCalalogueView subviews].count;
    NSInteger currentRow = subViewNums/line + 1;
    NSInteger currentLine = subViewNums%line + 1;
    
    // addCalalogueView最后一个UIButton的frame
    // 添加的BUtton在addView中得位置
    __block CGRect currentRect = CGRectMake((currentLine-1) * WIDTH/4+10,30*(currentRow-1)+5*currentRow, WIDTH/4 - 20, 30);
    
    // 将当前的button插入bodyScrollView视图
    [self.bodyScroll insertSubview:button atIndex:[self.bodyScroll subviews].count];
    
    button.frame = currentRect;
    // 将当前的button插入addCalalogueView视图
    [self.addCalalogueView insertSubview:button atIndex:[self.addCalalogueView subviews].count];
    //为button添加新的响应事件
    [button removeTarget:self action:@selector(removePersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(insertPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    for (DeletePoint *deletePoint in [button subviews]) {
        if ([deletePoint isMemberOfClass:[DeletePoint class]]) {
            [deletePoint removeFromSuperview];
        }
    }
    // 移动后要重新改变addCalalogueView的高度
    UIButton *lastAddBtn = [[self.addCalalogueView subviews] lastObject];
    NSInteger lastAddheight = CGRectGetMaxY(lastAddBtn.frame);
    CGRect lastAddrect = self.addCalalogueView.frame;
    lastAddrect.size.height = lastAddheight + 5;
    self.addCalalogueView.frame = lastAddrect;
    // 移动后要重新改变personalCatalogueView的高度
    UIButton *lastPersonalBtn = [[self.personalCatalogueView subviews] lastObject];
    NSInteger lastPersonalheight = CGRectGetMaxY(lastPersonalBtn.frame);
    CGRect lastPersonalrect = self.personalCatalogueView.frame;
    lastPersonalrect.size.height = lastPersonalheight + 5;
    self.personalCatalogueView.frame = lastPersonalrect;
    
    
    //移动后要重新加载personalCatalogue和addCalalogue视图
    //删除personalCatalogue原来的子视图
    for (UIButton  *button in [self.personalCatalogueView subviews]) {
        [button removeFromSuperview];
    }
    //重载personalCatalogue视图
    [self initWithPersonalCatalogue];
    
    //移动后要重新加载addlabel
    self.addlabel.frame = CGRectMake(10, CGRectGetMaxY(self.personalCatalogueView.frame), WIDTH - 20, 30);
    
    //移动后要重新addArray数据（加入数据）
    [addArray insertObject:str atIndex:addArray.count - 1];
    
    //移动后要重新改变addCalalogueView的原点
    CGRect  addFrame = self.addCalalogueView.frame;
    addFrame.origin.y = CGRectGetMaxY(self.addlabel.frame);
    self.addCalalogueView.frame = addFrame;
}

#pragma mark - 点击添加分类按钮触发事件
- (void)insertPersonalAction:(UIButton *)button
{
    //删除addArray对应的数据
    NSInteger buttonTag = button.tag;
    NSLog(@"%ld",(long)buttonTag);
    NSString *str = [addArray objectAtIndex:buttonTag - 1];
    NSLog(@"%@",str);
    [addArray removeObjectAtIndex:buttonTag - 1];
    
    NSInteger subViewNums = [self.personalCatalogueView subviews].count;
    NSInteger currentRow = subViewNums/line + 1;
    NSInteger currentLine = subViewNums%line + 1;
    
    // addCalalogueView最后一个UIButton的frame
    // 添加的BUtton在addView中得位置
    __block CGRect currentRect = CGRectMake((currentLine-1) * WIDTH/4+10,30*(currentRow-1)+5*currentRow, WIDTH/4 - 20, 30);
    
    // 将当前的button插入bodyScrollView视图
    [self.bodyScroll insertSubview:button atIndex:[self.bodyScroll subviews].count];
    
    button.frame = currentRect;
    // 将当前的button插入addCalalogueView视图
    [self.personalCatalogueView insertSubview:button atIndex:[self.personalCatalogueView subviews].count];
    //为button添加新的响应事件
    [button removeTarget:self action:@selector(insertPersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(removePersonalAction:) forControlEvents:UIControlEventTouchUpInside];
    // 移动后要重新改变addCalalogueView的高度
    UIButton *lastAddBtn = [[self.addCalalogueView subviews] lastObject];
    NSInteger lastAddheight = CGRectGetMaxY(lastAddBtn.frame);
    CGRect lastAddrect = self.addCalalogueView.frame;
    lastAddrect.size.height = lastAddheight + 5;
    self.addCalalogueView.frame = lastAddrect;
    // 移动后要重新改变personalCatalogueView的高度
    UIButton *lastPersonalBtn = [[self.personalCatalogueView subviews] lastObject];
    NSInteger lastPersonalheight = CGRectGetMaxY(lastPersonalBtn.frame);
    CGRect lastPersonalrect = self.personalCatalogueView.frame;
    lastPersonalrect.size.height = lastPersonalheight + 5;
    self.personalCatalogueView.frame = lastPersonalrect;
    
    //移动后要重新加载personalCatalogue和addCalalogue视图
    //删除personalCatalogue原来的子视图
    for (UIButton  *button in [self.addCalalogueView subviews]) {
        [button removeFromSuperview];
    }
    //重载personalCatalogue视图
    [self initWithAddCalalogue];
    
    //移动后要重新加载addlabel
    self.addlabel.frame = CGRectMake(10, CGRectGetMaxY(self.personalCatalogueView.frame), WIDTH - 20, 30);
    
    //移动后要重新addArray数据（加入数据）
    [personalArray insertObject:str atIndex:personalArray.count - 1];
    
    //移动后要重新改变addCalalogueView的原点
    CGRect  addFrame = self.addCalalogueView.frame;
    addFrame.origin.y = CGRectGetMaxY(self.addlabel.frame);
    self.addCalalogueView.frame = addFrame;
}

#pragma mark - 下拉视图
- (void)btnAddorDeleteAction:(UIButton *)button
{
    [self removeFromSuperview];
}

@end
