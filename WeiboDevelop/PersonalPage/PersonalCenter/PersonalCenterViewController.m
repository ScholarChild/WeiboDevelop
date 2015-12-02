#import "PersonalCenterViewController.h"
#import "DataManager.h"
#import "UserHeaderView.h"
#import "PersonalCenterFirstView.h"
#import "PersonalNaviView.h"
#import "PersonalCenterSecondView.h"
#import "PersonalCenerThirdView.h"


#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface PersonalCenterViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UserHeaderView *headerView;
    PersonalNaviView *naviView;
    PersonalCenterFirstView *firstView;
    PersonalCenterSecondView *secondView;
    PersonalCenerThirdView *thirdView;

    CGFloat contentHeight;
    
    WBUser *userData;
}
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,20, Width, Height)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    
    headerView = [[UserHeaderView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 200)];
    headerView.userData = [DataManager dataJson:@"真小寒"];

    [headerView layoutSubviews];
    naviView = [[PersonalNaviView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), Width, 40)];
    naviView.btnDelegate = self;
    
    [_scrollView addSubview:headerView];
    [_scrollView addSubview:naviView];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(0, 0, 60, 40);
    [backBtn1 setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return@3x.png"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    backBtn1.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn1];
    [self.navigationItem setLeftBarButtonItem:backBtn];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    firstView = [[PersonalCenterFirstView alloc]init];

    secondView = [[PersonalCenterSecondView alloc]init];

    thirdView = [[PersonalCenerThirdView alloc]init];
     secondView.alpha = 0;
    [_scrollView addSubview:firstView];
    [_scrollView addSubview:secondView];
    [_scrollView addSubview:thirdView];
    
    [_scrollView bringSubviewToFront:naviView];
}

-(void)changeView:(NSInteger)index
{
    if (index == 0) {
        firstView.alpha = 1;
        secondView.alpha = 0;
        CGSize size = firstView.frame.size;
        size.height+=240;
         _scrollView.contentSize = size;
    }
    if (index == 1) {
        firstView.alpha = 0;
        secondView.alpha = 1;
        CGSize size = [secondView getContentSize];
         size.height+=240;
         _scrollView.contentSize = size;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    CGSize size = [firstView getContentSize];
    secondView.alpha = 0;
    size.height+=240;
    _scrollView.contentSize = size;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y>=92){
        naviView.frame=CGRectMake(0,scrollView.contentOffset.y+44, Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    if(scrollView.contentOffset.y<=92){
        naviView.frame=CGRectMake(0, CGRectGetMaxY(headerView.frame), Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
//    NSLog(@"Y=%f",scrollView.contentOffset.y);
}
- (void)backBtnAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
