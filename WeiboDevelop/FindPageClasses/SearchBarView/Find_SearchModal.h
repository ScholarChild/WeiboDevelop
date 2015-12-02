//
//  Find_SearchModal.h
//  WeiboFind
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Find_SearchModal : NSObject

@property(nonatomic,copy)NSDictionary *buttondic;
@property(nonatomic,copy)NSDictionary *tableviewdic;

//设置UIbutton时的数据接口
- (void)initWithButtonDictionary:(NSDictionary *)dic;

//设置UITableView的数据接口
- (void)initWithTableViewDictionary:(NSDictionary *)dic;

@end
