#import "PersonalCenterFirstView.h"
#import "DataManager.h"

@interface PersonalCenterFirstView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArr;
    UITableView *_tableview;
    
}
@end
@implementation PersonalCenterFirstView

- (instancetype)init
{
    if (self = [super init]) {
     self.frame = CGRectMake(0, 240-64, [UIScreen mainScreen].bounds.size.width, 0);
    NSLog(@"init");
    self.backgroundColor = [UIColor lightGrayColor];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 667) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.scrollEnabled = YES;
    _tableview.bounces = NO;
        
    NSArray *arr1 = @[@"所在地    广东",@"更多基本资料"];
    NSArray *arr2 = @[@"我的热门内容"];
    NSArray *arr3 = @[@"我的热门内容"];
    NSArray *arr4 = @[@"我的热门内容"];
    NSArray *arr5 = @[@"我的热门内容"];
    _dataArr = @[arr1,arr2,arr3,arr4,arr5,arr5,arr5,arr5,arr5,arr5,arr5,arr5,arr5];
    }
    [self addSubview:_tableview];
    
    return self;
}
- (CGSize)getContentSize
{
    CGRect rect = _tableview.frame;
    rect.size.height = _tableview.contentSize.height;
    _tableview.frame = rect;
    self.frame = CGRectMake(0, 240-64, [UIScreen mainScreen].bounds.size.width, rect.size.height-64);
    NSLog(@"%f",_tableview.contentSize.height);
    return _tableview.contentSize;
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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *arr = _dataArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0 )
    {
        return 40;
    }
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}


@end
