//
//  WBPrivary.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBDataObject.h"

@interface WBPrivary : WBDataObject

@property (nonatomic,assign)NSNumber*	comment;//是否可以评论我的微博，0：所有人、1：关注的人、2：可信用户
@property (nonatomic,assign)NSNumber*	geo;//	是否开启地理信息，0：不开启、1：开启
@property (nonatomic,assign)NSNumber*	message;//	是否可以给我发私信，0：所有人、1：我关注的人、2：可信用户
@property (nonatomic,assign)NSNumber*	realname;//	是否可以通过真名搜索到我，0：不可以、1：可以
@property (nonatomic,assign)NSNumber*	badge;//	勋章是否可见，0：不可见、1：可见
@property (nonatomic,assign)NSNumber*	mobile;//	是否可以通过手机号码搜索到我，0：不可以、1：可以
@property (nonatomic,assign)NSNumber*	webim;//	是否开启webim， 0：不开启、1：开启

@end
