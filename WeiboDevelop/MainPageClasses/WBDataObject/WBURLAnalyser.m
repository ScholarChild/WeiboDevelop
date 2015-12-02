//
//  InfoManager.m
//  DZWeibo
//
//  Created by Ibokan on 15/10/15.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBURLAnalyser.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "WBComment.h"
#import "MJExtension.h"

@interface WBURLAnalyser()
{
    NSMutableArray* _infoList;
}
@end

@implementation WBURLAnalyser

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


- (NSArray *)latestHomeStatuses
{
    return [self latestHomeStatusesWithCount:20];
}

- (NSArray *)latestHomeStatusesWithCount:(NSInteger)count;
{
    NSString* urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?%@&count=%lu",[self requestkey],count];
    
    NSDictionary* jsonDic = [self jsonDicWithURL:[NSURL URLWithString:urlStr]];
    NSArray* stuatusDataArr = [jsonDic objectForKey:@"statuses"];
    NSArray* statuses = [self statusesFromDicArray:stuatusDataArr];
    return statuses;
}

- (NSArray*)lastestPersonalStatus
{
    NSString* request = [[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?%@&screen_name=%@",[self requestkey],PersonalUserName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* jsonDic = [self jsonDicWithURL:[NSURL URLWithString:request]];
    NSArray* stuatusDataArr = [jsonDic objectForKey:@"statuses"];
    NSArray* statuses = [self statusesFromDicArray:stuatusDataArr];
    return statuses;
}

- (WBUser*)personalInfo
{
    return [self personalInfoWithUserName:PersonalUserName];
}


- (WBUser*)personalInfoWithUserName:(NSString*)userName
{
    NSString* request = [[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?%@&screen_name=%@",[self requestkey],userName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* jsonDic = [self jsonDicWithURL:[NSURL URLWithString:request]];
    WBUser* user = [WBUser mj_objectWithKeyValues:jsonDic];
    return user;
}


- (NSString*)requestkey
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

- (NSDictionary*)jsonDicWithURL:(NSURL*)url
{
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *weiboDic = [NSJSONSerialization JSONObjectWithData:response
                                                             options:NSJSONReadingMutableLeaves error:&error];
    NSAssert(error == nil,@"json anaysic fail,some error happen");
    
    return weiboDic;
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

@end
