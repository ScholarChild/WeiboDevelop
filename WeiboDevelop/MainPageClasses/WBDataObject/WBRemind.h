//
//  Remind.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBDataObject.h"

@interface WBRemind : WBDataObject

@property (nonatomic,assign)NSNumber*	tatus;//	新微博未读数
@property (nonatomic,assign)NSNumber*	follower;//	新粉丝数
@property (nonatomic,assign)NSNumber*	cmt;//	新评论数
@property (nonatomic,assign)NSNumber*	dm;//	新私信数
@property (nonatomic,assign)NSNumber*	mention_status;//	新提及我的微博数
@property (nonatomic,assign)NSNumber*	mention_cmt;//	新提及我的评论数
@property (nonatomic,assign)NSNumber*	group;//	微群消息未读数
@property (nonatomic,assign)NSNumber*	private_group;//	私有微群消息未读数
@property (nonatomic,assign)NSNumber*	notice;//	新通知未读数
@property (nonatomic,assign)NSNumber*	invite;//	新邀请未读数
@property (nonatomic,assign)NSNumber*	badge;//	新勋章数
@property (nonatomic,assign)NSNumber*	photo;//	相册消息未读数
@property (nonatomic,assign)NSNumber*	msgbox;//	{{{3}}}

@end
