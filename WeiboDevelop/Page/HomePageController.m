//
//  HomePageController.m
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

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
    [self initTableView];
    [self updateStatusList];
    [self prepareForStatus];
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
    _statusesList = [_manager latestStatusesWithCount:20];
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
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBCellPreparer* preparer = [_cellPrepareres objectAtIndex:[indexPath row]];
    return preparer.heightOfCell;
}

@end
