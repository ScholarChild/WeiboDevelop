//
//  CM_CommentData.m
//  测试微博开发
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "CM_Comment.h"
#import "CM_comments.h"
#import "CM_data.h"
#import "CM_user.h"
#import "MJExtension.h"

@implementation CM_Comment
-(NSArray *)dicComment:(NSString* )number;
{
    //3903357762941127
    NSString* str=[NSString stringWithFormat:@"https://api.weibo.com/2/comments/show.json?source=%@&id=%@&access_token=%@",appKey,number,access_token];
    
    NSURL* url=[NSURL URLWithString:str];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData* data1=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray* dataDit=[NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
    CM_data* data=[CM_data mj_objectWithKeyValues:dataDit];
    
    NSArray* arr=[CM_comments mj_objectArrayWithKeyValuesArray:data.comments];
    NSMutableDictionary*dic;
    NSMutableArray* mArr=[[NSMutableArray alloc]init];
    
    for (CM_comments* commt in arr) {
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:commt.user.profile_image_url forKey:@"profile_image_url"];
        [dic setObject:commt.user.name forKey:@"name"];
        [dic setObject:commt.created_at forKey:@"created_at"];
        [dic setObject:commt.text forKey:@"text"];
        [mArr addObject:dic];
       
    }
    
   
    return mArr;
    
}
@end
