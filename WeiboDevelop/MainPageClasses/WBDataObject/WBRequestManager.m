//
//  InfoManager.m
//  DZWeibo
//
//  Created by Ibokan on 15/10/15.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBRequestManager.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "WBURL.h"
#import "WBComment.h"

#import "MJExtension.h"
#import "AFNetworking.h"


@interface WBRequestManager()
{
    NSMutableArray* _infoList;
}
@end

@implementation WBRequestManager
#pragma mark 初始化
- (instancetype)init
{
    if (self = [super init]) {
        [self setReplaceKey];
    }
    return self;
}

- (void)setReplaceKey
{
    [WBStatus mj_setupReplacedKeyFromPropertyName:^NSDictionary*{
        return @{
                 @"statusID" : @"id"
                 };
    }];
    [WBComment mj_setupReplacedKeyFromPropertyName:^NSDictionary*{
        return @{
                 @"ID" : @"id"
                 };
    }];
    [WBUser mj_setupReplacedKeyFromPropertyName:^NSDictionary*{
        return @{
                 @"descriptionText" :@"description"
                 };
    }];
}
#pragma mark 同步请求处理，返回对象

- (NSArray *)latestHomeStatusesWithCount:(NSInteger)count;
{
    NSString* request = [NSString stringWithFormat:
                         @"https://api.weibo.com/2/statuses/home_timeline.json?%@&count=%lu",
                         [self tokenStr],count];
    return [self statusesWithRequest:request];
}

- (NSArray*)lastestPersonalStatus
{
    NSString* request = [NSString stringWithFormat:
                         @"https://api.weibo.com/2/statuses/user_timeline.json?%@&screen_name=%@",
                         [self tokenStr],PersonalUserName];
    return [self statusesWithRequest:request];
}

- (WBUser*)personalInfoOfCurrentUser
{
    return [self personalInfoWithUserName:PersonalUserName];
}

- (WBUser*)personalInfoWithUserName:(NSString*)userName
{
    NSURL* request = [self personalRequestWithUserName:userName];
    NSDictionary* jsonDic = [self jsonDicWithURL:request];
    WBUser* user = [WBUser mj_objectWithKeyValues:jsonDic];
    return user;
}

#pragma mark 请求构建

- (NSURL*)personalRequestWithUserName:(NSString*)userName
{
    NSString* requestString =  [NSString stringWithFormat:
                                @"https://api.weibo.com/2/users/show.json?%@&screen_name=%@",
                                [self tokenStr],userName];
    return [self requestURLFromString:requestString];
}

- (NSURL*)topicSearchRequestWithSearchKeyword:(NSString*)keyWord
{
    NSString* requestString =  [NSString stringWithFormat:
                                @"https://api.weibo.com/2/search/topics.json?%@&q=%@",
                                [self tokenStr],keyWord];
    return [self requestURLFromString:requestString];
}

- (NSURL*)longURLFromShortURLString:(NSString*)shortURLString
{
    NSString* requestString =  [NSString stringWithFormat:
                                @"https://api.weibo.com/2/short_url/expand.json?%@&url_short=%@",
                                [self tokenStr],shortURLString];
    NSURL* shortURL =  [self requestURLFromString:requestString];
    NSDictionary* jsonDic = [self jsonDicWithURL:shortURL];
    NSDictionary* objDic = [[jsonDic  objectForKey:@"urls"] objectAtIndex:0];
    WBURL* URL = [WBURL mj_objectWithKeyValues:objDic];
    NSString* longURLString = URL.url_long;
    return [self requestURLFromString:longURLString];
}

#pragma mark 异步请求


- (void)homeStatusesWithSinceID:(NSString*)sinceID maxID:(NSString*)maxID
              didReiceverStatus:(void (^)(WBStatus*))handleStatus
                         finish:(void(^)())finishHandle  fail:(void(^)(NSError*))failHandle
{
    NSString* request = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary* parametersTmp = [NSMutableDictionary dictionaryWithDictionary:[self tokenDic]];
    [parametersTmp setObject:sinceID forKey:@"since_id"];
    [parametersTmp setObject:maxID forKey:@"max_id"];
    NSDictionary* parameters = [NSDictionary dictionaryWithDictionary:parametersTmp];
    
    [self statusWithRequest:request parameters:parameters didReiceverStatus:handleStatus finish:finishHandle fail:failHandle];
}

- (void)personalStatusesWithDidReiceverStatus:(void (^)(WBStatus*))handleStatus
                         finish:(void(^)())finishHandle  fail:(void(^)(NSError*))failHandle
{
    NSString* request = @"https://api.weibo.com/2/statuses/user_timeline.json";
    NSMutableDictionary* parametersTmp = [NSMutableDictionary dictionaryWithDictionary:[self tokenDic]];
    NSDictionary* parameters = [NSDictionary dictionaryWithDictionary:parametersTmp];
    
    [self statusWithRequest:request parameters:parameters didReiceverStatus:handleStatus finish:finishHandle fail:failHandle];
}




- (void)statusWithRequest:(NSString*)request parameters:(NSDictionary*)parameters
        didReiceverStatus:(void (^)(WBStatus*))handleStatus
                   finish:(void(^)())finishHandle  fail:(void(^)(NSError*))failHandle
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:request parameters:parameters
         success:^(NSURLSessionDataTask* task ,id responseObeject){
             NSArray* stuatusDataArr = [responseObeject objectForKey:@"statuses"];
             NSArray* statuses = [self statusesFromDicArray:stuatusDataArr];
             if (handleStatus) {
                 for (WBStatus* status in statuses) {
                     handleStatus(status);
                 }
             }
             if (finishHandle) {
                 finishHandle();
             }
         }
         failure:^(NSURLSessionDataTask* task ,NSError* error){
             if (failHandle) {
                 failHandle(error);
             }
         }
     ];
}




#pragma mark 内部公用函数

- (NSArray *)statusesWithRequest:(NSString*)requestString
{
    NSURL* requestURL = [self requestURLFromString:requestString];
    NSDictionary* jsonDic = [self jsonDicWithURL:requestURL];
    NSArray* stuatusDataArr = [jsonDic objectForKey:@"statuses"];
    NSArray* statuses = [self statusesFromDicArray:stuatusDataArr];
    return statuses;
}

- (NSURL*)requestURLFromString:(NSString*)requestString
{
    return [NSURL URLWithString:[requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSDictionary*)jsonDicWithURL:(NSURL*)url
{
    NSError *error = nil;
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    NSAssert1(error == nil,@"json anaysic fail,some error happen,%@",error);
//    
//    NSDictionary *weiboDic = [NSJSONSerialization JSONObjectWithData:response
//                                                             options:NSJSONReadingMutableLeaves error:&error];
    
    ////////
    
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSURLRequest *request = [requestSerializer
                                    requestBySerializingRequest:[NSURLRequest requestWithURL:url]       withParameters:nil error:&error];
    if (error != nil) {
        NSLog(@"%s,\n%@",__func__,error);
        return nil;
    }
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    
    NSDictionary *jsonDic = [requestOperation responseObject];
    return jsonDic;
}

- (NSArray*)statusesFromDicArray:(NSArray*)dicArr
{
    NSMutableArray* stuatues = [[NSMutableArray alloc]initWithCapacity:1];
    for (NSDictionary* stuatusDataDic in dicArr) {
        WBStatus* aStatus = [WBStatus mj_objectWithKeyValues:stuatusDataDic];
        [stuatues addObject:aStatus];
    }
    return stuatues;
}

- (NSString*)tokenStr
{
    NSString* key = @"";
    BOOL hasToken = (access_token != NULLString);
    BOOL hasSource = (appKey != NULLString);
    
    if (hasToken) {
        key = [NSString stringWithFormat:@"access_token=%@",access_token];
    }else if (hasSource) {
        key = [NSString stringWithFormat:@"source=%@",appKey];
    }else if (hasSource&&hasToken) {
        key = [NSString stringWithFormat:@"access_token=%@&source=%@",access_token,appKey];
    }
    return key;
}

- (NSDictionary*)tokenDic
{
    NSDictionary* tokenDic = @{};
    BOOL hasToken = (access_token != NULLString);
    BOOL hasSource = (appKey != NULLString);
    
    if (hasToken) {
        tokenDic = @{@"access_token":access_token};
    }else if (hasSource) {
        tokenDic = @{@"source":appKey};
    }else if (hasSource&&hasToken) {
        tokenDic = @{@"access_token":access_token,
                     @"source":appKey};
    }
    return tokenDic;
}

@end
