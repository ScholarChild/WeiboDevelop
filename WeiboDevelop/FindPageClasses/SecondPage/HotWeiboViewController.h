//
//  HotWeiboViewController.h
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"
@interface HotWeiboViewController : UIViewController

@property(nonatomic)FindViewController *delegate;
@property(strong)UIScrollView *topScroll;
@property(strong)UIButton *btnAddorDelete;
@property(strong)UIScrollView *bodyScroll;

@end
