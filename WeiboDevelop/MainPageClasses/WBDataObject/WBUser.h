//
//  WBUser.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBDataObject.h"
#import "WBStatus.h"


@interface WBUser : WBDataObject

//-------------------------------------------------
//基本信息
@property (nonatomic,assign)NSNumber* id;//用户UID
@property (nonatomic,retain)NSString* idstr;//字符串型的用户UID
@property (nonatomic,retain)NSString* screen_name;//用户昵称
@property (nonatomic,retain)NSString* gender;//性别，m：男、f：女、n：未知

@property (nonatomic,retain)NSString* avatar_large;//用户头像地址（大图），180×180像素
@property (nonatomic,retain)NSString* profile_image_url;//用户头像地址（中图），50×50像素
@property (nonatomic,retain)NSString* avatar_hd;//用户头像地址（高清），高清头像原图

@property (nonatomic,assign)NSNumber* province;// 用户所在省级ID
@property (nonatomic,assign)NSNumber* city;// 用户所在城市ID
@property (nonatomic,retain)NSString* location;//用户所在地

@property (nonatomic,retain)NSString* created_at;//用户创建（注册）时间
@property (nonatomic,retain)NSString* descriptionText;//用户个人描述
@property (nonatomic,retain)NSString* domain;//用户的个性化域名
@property (nonatomic,retain)NSString* lang;//用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语

@property (nonatomic,retain)NSString* profile_url;//用户的微博统一URL地址
@property (nonatomic,retain)NSString* url;//用户博客地址
@property (nonatomic,retain)NSString* weihao;//用户的微号

//-------------------------------------------------
//关系
@property (nonatomic,assign)BOOL follow_me;// 该用户是否关注当前登录用户，true：是，false：否
@property (nonatomic,assign)BOOL following;
@property (nonatomic,assign)NSString* remark;//用户备注信息，只有在查询用户关系时才返回此字段
@property (nonatomic,retain)NSString* name;//友好显示名称

//-------------------------------------------------
//权限设置
@property (nonatomic,assign)BOOL allow_all_act_msg;// 是否允许所有人给我发私信，true：是，false：否
@property (nonatomic,assign)BOOL allow_all_comment;// 是否允许所有人对我的微博进行评论，true：是，false：否
@property (nonatomic,assign)BOOL geo_enabled;// 是否允许标识用户的地理位置，true：是，false：否
@property (nonatomic,assign)BOOL verified;// 是否是微博认证用户，即加V用户，true：是，false：否

//-------------------------------------------------
//好友相关
@property (nonatomic,assign)NSNumber* followers_count;// 粉丝数
@property (nonatomic,assign)NSNumber* friends_count;// 关注数
@property (nonatomic,assign)NSNumber* bi_followers_count;// 用户的互粉数
@property (nonatomic,assign)NSNumber* favourites_count;// 收藏数

//-------------------------------------------------
//状态
@property (nonatomic,assign)NSNumber* online_status;// 用户的在线状态，0：不在线、1：在线
@property (nonatomic,assign)NSNumber* statuses_count;// 微博数
@property (nonatomic,retain)WBStatus* status;//用户的最近一条微博信息字段 详细
//-------------------------------------------------
//认证相关
@property (nonatomic,retain)NSString* verified_reason;//认证原因
@property (nonatomic,retain)NSString* verified_source;
@property (nonatomic,retain)NSString* verified_reason_modified;
@property (nonatomic,retain)NSString* verified_reason_url;
@property (nonatomic,assign)NSNumber* verified_state;
@property (nonatomic,assign)NSNumber* verified_level;
@property (nonatomic,assign)NSNumber* verified_type;
//-------------------------------------------------
//未知
@property (nonatomic,assign)NSNumber* user_ability;
@property (nonatomic,assign)NSNumber* block_word;
@property (nonatomic,assign)NSNumber* block_app;
@property (nonatomic,retain)NSString* cardid;
@property (nonatomic,assign)NSNumber* credit_score;
@property (nonatomic,assign)NSNumber* ptype;
@end

//过滤清单
//@"cover_image",@"cover_image_phone",
//                            @"urank",
//                            @"mbrank",
//                            @"mbtype",
//                            @"class",
//                            @"ability_tags",
//                            @"star",
//                            @"dianping",
//                            @"verified_contact_email",
//                            @"verified_trade",
//                            @"verified_contact_mobile",
//                            @"verified_contact_name",
//                            @"verified_source_url",
//                            @"pagefriends_count",
