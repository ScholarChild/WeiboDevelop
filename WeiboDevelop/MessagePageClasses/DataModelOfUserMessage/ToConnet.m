//
//  ToConnet.m
//  微博开发1
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "ToConnet.h"
#import "ToData1.h"
#import "ToData.h"
#import "MJExtension.h"
#import "AFHTTPSessionManager.h"
@implementation ToConnet
+(NSArray *)allConnet
{
    NSString* str=@"https://api.weibo.com/2/friendships/friends.json?source=1626555808&screen_name=%E6%B2%B3%E5%8D%97%E7%BC%98-%E6%9D%A5%E5%A6%82%E6%AD%A4&access_token=2.00HGROgCGTrEmB3cc58d85cbIzgk4B";
    
    
    
    NSURL* url=[NSURL URLWithString:str];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray* dataDit=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //    NSLog(@"dataDit:%@",dataDit);
    ToData* userArr=[ToData mj_objectWithKeyValues:dataDit];
    NSArray* toArr=[ToData1 mj_objectArrayWithKeyValuesArray:userArr.users];
  
 
    NSArray* arr=[ToData1 mj_keyValuesArrayWithObjectArray:toArr];
    
    return arr;
}
@end
