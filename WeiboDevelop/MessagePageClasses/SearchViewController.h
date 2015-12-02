//
//  SearchViewController.h
//  微博开发1
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (nonatomic, strong) UISearchController *searchController;
-(id)initName:(NSArray*)arr;
@end
