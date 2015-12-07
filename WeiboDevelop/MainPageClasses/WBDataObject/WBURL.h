//
//  Url_short.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBDataObject.h"

@interface WBURL : WBDataObject

@property (nonatomic,retain)NSString*	url_short;//短链接
@property (nonatomic,retain)NSString*	url_long;//原始长链接
@property (nonatomic,assign)NSInteger	type;//	链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
@property (nonatomic,assign)BOOL        result;//	短链的可用状态，true：可用、false：不可用。

@end
