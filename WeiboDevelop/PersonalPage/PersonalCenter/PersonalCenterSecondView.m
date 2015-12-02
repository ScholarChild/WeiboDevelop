#import "PersonalCenterSecondView.h"
@interface PersonalCenterSecondView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *_tableview;
    
}
@end
@implementation PersonalCenterSecondView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen    mainScreen].bounds.size.width, 667) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        
        _tableview.bounces = NO;
        [self addSubview:_tableview];
        _dataArr = [NSMutableArray new];
        for (int i = 0; i< 20; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"第%d条微博",i]];
        }

    }
    
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    cell.textLabel.text = _dataArr[indexPath.row];
    
    
    return cell;
}


@end