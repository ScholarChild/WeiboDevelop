#import "PersonalCenterController.h"
#import "UserHeaderView.h"
#import "PersonalNaviView.h"
#import "PersonalCenterDataManager.h"
#import "PersonalCenterPhotoCell.h"
#import "AFNetworking.h"
#import "WBContainCell.h"
#import "WBCellController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface PersonalCenterController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_dataArr;
    NSMutableArray *_dataContainer;
    
    UserHeaderView *_topView;
    PersonalNaviView *_naviView;
    NSInteger pageNum;
    UIView *_headerView;
    
    NSMutableArray* _cellControlleres;
    WBRequestManager* _manager;
    
    UIRefreshControl *_control;
    UIActivityIndicatorView *_AIV;
}
@end
@implementation PersonalCenterController
- (instancetype)init
{
    if (self = [super init]) {
        _cellControlleres = [NSMutableArray new];
        _manager = [WBRequestManager manager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateStatusList];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -44, 375, 667+44) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _dataArr = [NSMutableArray arrayWithObjects:_cellControlleres, nil];
    _dataContainer = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    pageNum = 0;
    [self.view addSubview:_tableview];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 240)];
    _topView = [[UserHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _topView.userData = _userData;
    _naviView = [[PersonalNaviView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), Width, 40)];
    _naviView.btnDelegate = self;
    [_headerView addSubview:_topView];
    [_headerView addSubview:_naviView];

    _tableview.tableHeaderView = _headerView;
    [_tableview sendSubviewToBack:_headerView];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"tabbar_compose_background_icon_return@3x.png"];
    UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn1.frame = CGRectMake(0, 0, 60, 40);
    [backBtn1 setImage:btnImage forState:UIControlStateNormal];
    backBtn1.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backBtn1 addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn1];
    [self.navigationItem setLeftBarButtonItem:backBtn];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self setupRefresh];
}
-(void)setupRefresh
{
    //1.添加刷新控件
    _control=[[UIRefreshControl alloc]init];
    [_control addTarget:self action:@selector(updateStatusList) forControlEvents:UIControlEventValueChanged];
    [_tableview addSubview:_control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [_control beginRefreshing];
    
    // 3.加载数据
    [self updateStatusList];
}
-(void)backBtnAction:(UIButton *)btn
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)updateStatusList
{
    
//    UIView *view = [[UIView alloc]initWithFrame:_tableview.frame];
//    view.backgroundColor = [UIColor grayColor];
//    [view addSubview:_AIV];
//    _AIV = [[UIActivityIndicatorView alloc]initWithFrame:_tableview.frame];
//    [self.view addSubview:view];
//    [_AIV startAnimating];
    
    __block NSInteger insertPosition = 0;
    [_manager personalStatusesWithDidReiceverStatus:^(WBStatus* status){
        WBCellController* cellController = [[WBCellController alloc]initWithStatus:status];
        [_cellControlleres insertObject:cellController atIndex:insertPosition];
        [self addChildViewController:cellController];
        insertPosition++;
    } finish:^{
        [_tableview reloadData];
        [_control endRefreshing];
    } fail:^(NSError* err){
        [_control endRefreshing];
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGRect rect = _topView.imageRect;
    if (scrollView.contentOffset.y >= -187) {
        rect.origin.y += scrollView.contentOffset.y*0.5;
        [_topView setBackgroundImageFrame:rect];
    }
    else
    {
        rect.origin.y += -95;
        NSLog(@"---%f",scrollView.contentOffset.y);
        
        [_topView setBackgroundImageFrame:rect];
    }
    if(_tableview.contentOffset.y>=92){
        [_naviView removeFromSuperview];
        [self.view addSubview:_naviView];
        _naviView.frame=CGRectMake(0,64, Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    if(_tableview.contentOffset.y <= 92 &&_tableview.contentOffset.y>10){
        [_naviView removeFromSuperview];
        [_headerView addSubview:_naviView];
        _naviView.frame=CGRectMake(0, CGRectGetMaxY(_topView.frame), Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = [_dataArr objectAtIndex:section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id returnCell;
    if (pageNum == 0) {
        NSString* iden = [NSString stringWithFormat:@"iden %lu",([indexPath row] % 6)];
        WBContainCell* cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (!cell) {
            cell = [[WBContainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        WBCellController* cellController = [_cellControlleres objectAtIndex:[indexPath row]];
        [cellController constructCell:cell mode:WBContextCellModeDefault];
        
        returnCell = cell;
    }
    else if (pageNum == 1) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        NSArray *arr = [_dataArr objectAtIndex:indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
        returnCell = cell;
    }
    else{
        
        PersonalCenterPhotoCell *cell = [[PersonalCenterPhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSArray *arr = [_dataArr objectAtIndex:indexPath.section];
        NSDictionary *dic =arr[indexPath.row];
        [cell addPhotoWithArray:dic];
        returnCell = cell;
    }
    return returnCell;
}
- (void)changeView:(NSInteger)index
{
    if (index == pageNum) {
        NSLog(@"return");
        return;
    }
    pageNum = index;
    
    if (index == 0) {
        _dataArr = [NSMutableArray arrayWithObjects:_cellControlleres, nil];
    }
    if (index == 1) {
        _dataArr = [NSMutableArray arrayWithArray:[PersonalCenterDataManager getWBStatusData]];
    }
    if (index == 2) {
        _dataArr = [NSMutableArray arrayWithArray:[PersonalCenterDataManager getPersonalPhotoesData]];
    }
    [_dataContainer replaceObjectAtIndex:index withObject:_dataArr];
    
    [_tableview reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (pageNum == 0) {
        WBCellController* cellController = [_cellControlleres objectAtIndex:[indexPath row]];
        return cellController.heightOfCell;
    }
    if (pageNum == 2) {
        return 667-240;
    }
    return 40;
}

@end
