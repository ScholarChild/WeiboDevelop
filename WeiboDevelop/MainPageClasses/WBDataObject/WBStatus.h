//
//  WeiboInfo.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/15.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBDataObject.h"
#import "WBGeo.h"
#import "WBVisible.h"

@class WBUser;
@interface WBStatus : WBDataObject

@property (nonatomic,retain)NSString* created_at;//微博创建时间
@property (nonatomic,assign)NSNumber* statusID;//微博ID
@property (nonatomic,assign)NSNumber* mid;//微博MID
@property (nonatomic,retain)NSString* idstr;//字符串型的微博ID
@property (nonatomic,retain)NSString* text;//微博信息内容

@property (nonatomic,retain)NSString* source;//微博来源
@property (nonatomic,assign)NSNumber* source_type;//(unknow)
@property (nonatomic,assign)NSNumber* source_allowclick;//(unknow)

@property (nonatomic,assign)BOOL favorited;// 是否已收藏，true：是，false：否
@property (nonatomic,assign)BOOL truncated;// 是否被截断，true：是，false：否
@property (nonatomic,assign)BOOL isLongText;//

@property (nonatomic,retain)NSString* in_reply_to_status_id;//（暂未支持）回复ID
@property (nonatomic,retain)NSString* in_reply_to_user_id;//（暂未支持）回复人UID
@property (nonatomic,retain)NSString* in_reply_to_screen_name;//（暂未支持）回复人昵称

@property (nonatomic,retain)NSString* thumbnail_pic;//缩略图片地址，没有时不返回此字段
@property (nonatomic,retain)NSString* bmiddle_pic;//中等尺寸图片地址，没有时不返回此字段
@property (nonatomic,retain)NSString* original_pic;//原始图片地址，没有时不返回此字段

@property (nonatomic,retain)WBGeo* geo;//地理信息字段 详细
@property (nonatomic,retain)WBUser* user;//微博作者的用户信息字段 详细
@property (nonatomic,retain)WBStatus* retweeted_status;//被转发的原微博信息字段，当该微博为转发微博时返回 详细
@property (nonatomic,assign)NSNumber* reposts_count;// 转发数
@property (nonatomic,assign)NSNumber* comments_count;// 评论数
@property (nonatomic,assign)NSNumber* attitudes_count;// 表态数

@property (nonatomic,retain)WBVisible* visible;//微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
//@property (nonatomic,retain)object pic_ids;//微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
//@property (nonatomic,retain)NSArray* ad;//array 微博流内的推广微博ID

//-----------------------------------
//未知属性

@property (nonatomic,retain)NSArray* darwin_tags;
@property (nonatomic,retain)NSArray* pic_urls;
@property (nonatomic,assign)NSNumber* page_type;

@property (nonatomic,assign)NSNumber* userType;
@property (nonatomic,assign)NSArray* annotations;
@property (nonatomic,assign)NSArray* biz_ids;
@property (nonatomic,assign)NSNumber* biz_feature;
@property (nonatomic,assign)NSNumber* mlevel;
@property (nonatomic,retain)NSString* cardid;
@property (nonatomic,assign)NSNumber* pid;
@property (nonatomic,retain)NSString* rid;

@end
