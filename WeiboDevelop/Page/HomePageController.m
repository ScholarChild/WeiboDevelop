#import "HomePageController.h"
#import "WeiboCell.h"
#import "WBCellPreparer.h"
#import "WBURLAnalyser.h"


@interface HomePageController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _cellPrepareres;
    WBURLAnalyser* _manager;
    UITableView* _table;
}
@end


@implementation HomePageController

- (instancetype)init
{
    if (self = [super init]) {
        _cellPrepareres = [NSMutableArray new];
        _manager = [WBURLAnalyser new];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self updateStatusList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initTableView];
    [super viewWillAppear:animated];
}

- (void)initTableView
{
    CGRect PageFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    _table = [[UITableView alloc]initWithFrame:PageFrame style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (void)updateStatusList
{
    [_manager latestHomeStatusesWithCount:20 didReiceverStatus:^(WBStatus* status){
        WBCellPreparer* preparer = [[WBCellPreparer alloc]initWithStatus:status];
        [_cellPrepareres addObject:preparer];
    } finish:^{
        [_table reloadData];
    } fail:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* iden = [NSString stringWithFormat:@"iden %lu",([indexPath row] % 6)];
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
