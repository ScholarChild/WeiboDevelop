//
//  InfoManager.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/15.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"
#import "WBStatus.h"

@interface WBURLAnalyser : NSObject

/*!
 * @discussion 返回当前授权用户所有关注的最新公共微博
 *
 * @result 以WBStatus 为元素的数组，数量为20条
 */
- (NSArray*)latestHomeStatuses;
/*!
 * @discussion 返回当前授权用户所有关注的最新公共微博
 *
 * @param count 返回微博的数量，不超过100
 *
 * @result 以WBStatus 为元素的数组，数量为count所指定数量
 */
- (NSArray*)latestHomeStatusesWithCount:(NSInteger)count;
/*!
 * @discussion 返回当前授权用户的最新个人微博，数量为5条
 *
 * @param count 返回微博的数量
 *
 * @result 以WBStatus 为元素的数组
 */
- (NSArray*)lastestPersonalStatus;

/*!
 * @discussion 返回当前授权用户的个人信息
 *
 * @result WBUser 存储个人信息的对象
 */
- (WBUser*)personalInfo;
/*!
 * @discussion 返回当前指定用户的个人信息
 *
 * @warning : 查询非当前用户的信息时，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
 *
 * @result WBUser 存储个人信息的对象
 */
- (WBUser*)personalInfoWithUserName:(NSString*)userName;


@end
