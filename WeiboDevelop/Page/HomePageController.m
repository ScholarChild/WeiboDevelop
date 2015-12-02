#import "HomePageController.h"
#import "WeiboCell.h"
#import "WBCellPreparer.h"
#import "WBURLAnalyser.h"


@interface HomePageController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _cellPrepareres;
    NSArray* _statusesList;
    WBURLAnalyser* _manager;
}
@end


@implementation HomePageController

- (instancetype)init
{
    if (self = [super init]) {
        _cellPrepareres = [NSMutableArray new];
        _manager = [WBURLAnalyser new];
        _statusesList = [NSArray new];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addNavi];
    [self initTableView];
    [self updateStatusList];
    [self prepareForStatus];
}

- (void)addNavi
{
#pragma mark 改页面
    //页面跳转使用模态跳转,自定义navigationBar
    UINavigationBar* bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20,CGRectGetWidth(self.view.frame), 44)];//定义一个NavigationBar，距离屏幕20，一个屏幕宽，44高度
    UINavigationItem* item=[[UINavigationItem alloc]initWithTitle:@"标题"];
    UIBarButtonItem* leftBar=[[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStylePlain  target:self action:@selector(leftAction)];
    item.leftBarButtonItem=leftBar;
    [bar pushNavigationItem:item animated:NO];//设置好BarButtonItem之后将Item绑定到Bar中
    [self.view addSubview:bar];
}

- (void)leftAction
{
    
}


- (void)initTableView
{
    CGRect PageFrame = self.view.frame;
    
    UITableView* table = [[UITableView alloc]initWithFrame:PageFrame style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (void)updateStatusList
{
    _statusesList = [_manager latestHomeStatusesWithCount:20];
}

- (void)prepareForStatus
{
    for (WBStatus* status in _statusesList) {
        WBCellPreparer* preparer = [[WBCellPreparer alloc]initWithStatus:status];
        [_cellPrepareres addObject:preparer];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* iden = [NSString stringWithFormat:@"iden %lu",([indexPath row] % 10)];
    WeiboCell* cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    WBCellPreparer* preparer = [_cellPrepareres objectAtIndex:[indexPath row]];
    [preparer constructCell:cell];
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellPrepareres count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBCellPreparer* preparer = [_cellPrepareres objectAtIndex:[indexPath row]];
    return preparer.heightOfCell;
}

@end
