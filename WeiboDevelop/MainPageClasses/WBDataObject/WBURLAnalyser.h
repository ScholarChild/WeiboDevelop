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
 * @param count 返回微博的数量，不超过100
 *
 * @result 以WBStatus 为元素的数组，数量为count所指定数量
 */
- (NSArray*)latestHomeStatusesWithCount:(NSInteger)count;
/*!
 * @discussion 返回当前授权用户所有关注的最新公共微博
 *
 * @param count 返回微博的数量，不超过100
 *
 * @param handleStatus 请求成功返回时会回调该block处理每个WBStatus对象
 *
 * @param finishHandle 请求成功返回并完成处理后，调用此模块进行后续处理
 *
 * @param failHandle 请求失败时回调该block进行错误处理
 *
 */
- (void)latestHomeStatusesWithCount:(NSInteger)count didReiceverStatus:(void (^)(WBStatus*))handleStatus
                             finish:(void(^)())finishHandle  fail:(void(^)(NSError*))failHandle;
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
- (WBUser*)personalInfoOfCurrentUser;
/*!
 * @discussion 返回当前指定用户的个人信息
 *
 * @param userName 用户名
 *
 * @warning : 查询非当前用户的信息时，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
 *
 * @result WBUser 存储个人信息的对象
 */
- (WBUser*)personalInfoWithUserName:(NSString*)userName;

/*!
 * @discussion 构建一个访问个人信息的请求URL
 *
 * @param userName 用户名
 *
 * @warning : 查询非当前用户的信息时，将无法获取其个人简介、认证原因、粉丝数、关注数、微博数及最近一条微博内容。
 *
 * @result 构建好请求的URL对象
 */
- (NSURL*)personalRequestWithUserName:(NSString*)userName;
/*!
 * @discussion 构建一个搜索话题的请求URL
 *
 * @param keyWord 搜索的话题关键字，只能是＃＃之间的关键字
 *
 * @warning : 该请求为高级接口，目前可以构建请求，但是返回的是错误信息的json
 *
 * @result 构建好请求的URL对象
 */
- (NSURL*)topicSearchRequestWithSearchKeyword:(NSString*)keyWord;
/*!
 * @discussion 将传入的短链字符转化为长链接，并将其封装成URL对象
 *
 * @param shortURL 短链接的文本；
 *
 * @result 长链接的URL对象
 */
- (NSURL*)longURLFromShortURLString:(NSString*)shortURLString;

@end
