#import "HomePageViewController.h"
#import "PersonalCenterViewController.h"
#import "DataManager.h"
#import "HomePageTableViewCell.h"
#import "UserInfoTableView.h"
#import "WBUser.h"
#import "AddFriendViewController.h"

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_dataArr;
    WBUser * userData;
}
@end
@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArr = [DataManager getPlistDataWithName:@"HomePageInfo"];
    userData = [DataManager dataJson:@"真小寒"];
    _tableview = [[UserInfoTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return@3x.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"我";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    leftBtn.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:nil];
    rightBtn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.view addSubview:_tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [[HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            [cell initHeadSubviews];
            cell.headUserData = userData;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            [cell initNeckSubviews];
            cell.neckUserData = userData;
        }
    }
    else{
        //本地
        NSDictionary * dic = [[_dataArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        [cell initBodySubviews];
        cell.dataDic = dic;  
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = [_dataArr objectAtIndex:section];
    return arr.count;
}

//section头部间距  不设=默认值
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0 && indexPath.row ==0)
    {
        return 80;
    }
    return  40;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (void)homePagePushUserInfoNum:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0&&indexPath.row ==0) {
        PersonalCenterViewController *personalCenterVC = [PersonalCenterViewController new];
        personalCenterVC.userData = userData;
        [self.navigationController pushViewController:personalCenterVC animated:YES];
    }
}
- (void)addFriend
{
    AddFriendViewController *addFriendVC = [AddFriendViewController new];
    
    [self.navigationController pushViewController:addFriendVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
