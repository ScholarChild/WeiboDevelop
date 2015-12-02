//
//  FindModal.h
//  WeiboFind
//
//  Created by ibokan on 15/11/25.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModal : NSObject

@property(nonatomic,copy)NSString *searchbarplaceholder;
@property(nonatomic,copy)NSDictionary *scrollviewdic;
@property(nonatomic,copy)NSDictionary *buttondic;

//设置searchBar的placeholder的接口
- (void)initWithSearchBarWithPlaceholder:(NSString *)placeholder;


@end
