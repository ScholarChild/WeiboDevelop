//
//  CM_CommentData.m
//  测试微博开发
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "CM_CommentData.h"

 

@implementation CM_CommentData
-(NSArray *)dicCommentData:(NSArray*)arr
{
  
    NSMutableArray* m_arr=[[NSMutableArray alloc]init];
    NSLog(@"获取评论开始");
    for (NSDictionary* dic in arr) {
        NSString* text=[dic objectForKey:@"text"];
        NSString* create=[dic objectForKey:@"created_at"];
        NSString* source=[dic objectForKey:@"source"];
        
        NSString* string=[source stringByReplacingOccurrencesOfString:@">" withString:@"<"];
        NSArray* arr=[string componentsSeparatedByString:@"<"];

        NSDictionary* dic1=[dic objectForKey:@"user"];
        NSString* userName=[dic1 objectForKey:@"name"];
        NSString* userProfile=[dic1 objectForKey:@"profile_image_url"];
        NSDictionary* dic2=[dic objectForKey:@"status"];
        NSString* statusText=[dic2 objectForKey:@"text"];
        NSDictionary* dic3=[dic2 objectForKey:@"user"];
        NSString* statusUserName=[dic3 objectForKey:@"name"];
        NSString* statusUserProfile=[dic3 objectForKey:@"profile_image_url"];
      
        
        NSDictionary* dic4=[[NSDictionary alloc]initWithObjectsAndKeys:
                            text,@"comment.text",
                            arr[arr.count/2],@"comment.source",
                            create,@"comment.created_at",
                            userName,@"comment.user.name",
                            userProfile,@"comment.user.profile_image_url",
                            statusText,@"commment.status.text",
                            statusUserName,@"comment.status.user.name",
                            statusUserProfile,@"comment.status.user.profile_image_url", nil];
        [m_arr addObject:dic4];
        
    }
    //各个网络的数据获取已经完成，接下来就是把他返回去一个方便使用的数组
    //数据获取。
   
    return m_arr;
    
}
@end
