#import "HomePageViewController.h"

#import "ArrInfo.h"
#import "HomePageTableViewCell.h"
#import "UserInfoTableView.h"

#import "WBURLAnalyser.h"
#import "WBUser.h"
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
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArr = [ArrInfo getPlistArr:@"HomePageInfo"];
    _tableview = [[UserInfoTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    WBURLAnalyser *analyser = [WBURLAnalyser new];
    userData = [analyser userInfoWithUserName:@"真小寒"];
    [self.view addSubview:_tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [[HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary * dic = [[_dataArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];

    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            cell.userImageName = userData.profile_image_url;
            cell.userName = userData.name;
            if (userData.descriptionText!=nil) {
                cell.userDetail = [@"简介: "  stringByAppendingString: userData.descriptionText];
            }
            cell.level = 2;
            
            [cell setHeadCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        }

        else{
            [cell.userInfoNumArr addObject:userData.statuses_count.description];
            [cell.userInfoNumArr addObject:userData.friends_count.description];
            [cell.userInfoNumArr addObject:userData.followers_count.description];
            
            [cell setNeckCell];
            [cell addBtnTarget:self action:@selector(homePagePushUserInfoNum:)];

        }
    }
    else{
        cell.iconName = [dic objectForKey:@"typeIcon"];
        cell.name = [dic objectForKey:@"name"];
        cell.detail = [dic objectForKey:@"detail"];
        
        [cell setBodyCell];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor =[UIColor redColor];
    //NSAttributedString*
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
