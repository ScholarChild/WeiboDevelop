#import "AddFriendViewController.h"

@interface AddFriendViewController()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSArray *_dataArr;
    UISearchBar *_searchBar;
    UISearchController *_searchBarController;
    UITableView *_tableview;
}
@end
@implementation AddFriendViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加好友";
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60*3+44+64) style:UITableViewStylePlain];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 44)];
    // 自动大写
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // 自动匹配类型
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _tableview.tableHeaderView = _searchBar;
    _tableview.rowHeight = 60;
    _searchBar.delegate = self;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"当面加好友",@"text",@"添加身边的好友",@"detail", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"扫一扫",@"text",@"扫描二维码名片",@"detail", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"通讯录好友",@"text",@"添加或邀请通讯录的好友",@"detail", nil];
    _dataArr = @[dic1,dic2,dic3];
    [self.view addSubview:_tableview];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cid];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"feedgroup_timeline_icon_message@2x.png"];
    cell.textLabel.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"text"];
    cell.detailTextLabel.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"detail"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
