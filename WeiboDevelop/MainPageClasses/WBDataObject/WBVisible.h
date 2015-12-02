//
//  WBVisible.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/30.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBDataObject.h"
//微博的可见性及指定可见分组信息。
@interface WBVisible : WBDataObject

@property (nonatomic,assign)NSInteger type;//0：普通微博，1：私密微博，3：指定分组微博，4：密友微博
@property (nonatomic,assign)NSInteger list_id;//分组的组号

@end
