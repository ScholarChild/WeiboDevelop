//
//  WBComment.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBDataObject.h"
#import "WBUser.h"
#import "WBStatus.h"

@interface WBComment : WBDataObject

@property (nonatomic,retain)NSString* ted_at;//评论创建时间
@property (nonatomic,assign)NSNumber* ID;//评论的ID
@property (nonatomic,retain)NSString* text;//评论的内容
@property (nonatomic,retain)NSString* source;//评论的来源
@property (nonatomic,retain)WBUser* user;//评论作者的用户信息字段 详细
@property (nonatomic,retain)NSString* mid;//评论的MID
@property (nonatomic,retain)NSString* idstr;//字符串型的评论ID
@property (nonatomic,retain)WBStatus* status;//评论的微博信息字段 详细
@property (nonatomic,retain)WBComment* reply_comment;//评论来源评论，当本评论属于对另一评论的回复时返回此字段

@end
