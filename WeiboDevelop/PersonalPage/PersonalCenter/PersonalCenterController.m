#import "PersonalCenterController.h"
#import "UserHeaderView.h"
#import "PersonalNaviView.h"
#import "PersonalCenterDataManager.h"
#import "PersonalCenterPhotoCell.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface PersonalCenterController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    
    NSArray *_dataArr;
    NSMutableArray *_dataContainer;
    
    UserHeaderView *_headerView;
    PersonalNaviView *_naviView;
    NSInteger pageNum;
    UIView *_tabeheaderView;
}
@end
@implementation PersonalCenterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -44, 375, 667+44) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _dataArr = [PersonalCenterDataManager getPersonalInfoData];
    _dataContainer = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    pageNum = 0;
    [self.view addSubview:_tableview];
    
    _tabeheaderView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 240)];
    _headerView = [[UserHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _headerView.userData = _userData;
    _naviView = [[PersonalNaviView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), Width, 40)];
    _naviView.btnDelegate = self;
    [_tabeheaderView addSubview:_headerView];
    [_tabeheaderView addSubview:_naviView];
    _tableview.tableHeaderView = _tabeheaderView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_tableview.contentOffset.y>=92){
        [_naviView removeFromSuperview];
        [self.view addSubview:_naviView];
        _naviView.frame=CGRectMake(0,64, Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    if(_tableview.contentOffset.y<=92 &&_tableview.contentOffset.y>10){
        [_naviView removeFromSuperview];
        [_tabeheaderView addSubview:_naviView];
        _naviView.frame=CGRectMake(0, CGRectGetMaxY(_headerView.frame), Width, 40);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section：%ld",_dataArr.count);
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = [_dataArr objectAtIndex:section];
    NSLog(@"row：%ld",arr.count);
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id returnCell;
    if (pageNum != 2) {
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
            _dataArr = [PersonalCenterDataManager getPersonalInfoData];
        }
        if (index == 1) {
            _dataArr = [PersonalCenterDataManager getWBStatusData];
        }
        if (index == 2) {
            _dataArr = [PersonalCenterDataManager getPersonalPhotoesData];
        }
        [_dataContainer replaceObjectAtIndex:index withObject:_dataArr];
    
    [_tableview reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (pageNum == 2) {
        return 667-240;
    }
    return 40;
}
//UIButton *backBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//backBtn1.frame = CGRectMake(0, 0, 60, 40);
//[backBtn1 setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return@3x.png"] forState:UIControlStateNormal];
//[backBtn1 addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//backBtn1.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
//UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn1];
//[self.navigationItem setLeftBarButtonItem:backBtn];
@end
