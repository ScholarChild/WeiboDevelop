//
//  CM_CommentData.m
//  测试微博开发
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "CM_CommentData.h"
#import "CM_ToMy_comments.h"
#import "CM_ToMy_data.h"
#import "CM_ToMy_status.h"
#import "CM_ToMy_stutasUser.h"
#import "CM_ToMy_user.h"
#import "MJExtension.h"

@implementation CM_CommentData
-(NSArray *)dicCommentData
{
    //3903357762941127
    NSString* str=@"https://api.weibo.com/2/comments/to_me.json?source=1626555808&access_token=2.00HGROgCGTrEmB3cc58d85cbIzgk4B";
    
    NSURL* url=[NSURL URLWithString:str];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData* data1=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray* dataDit=[NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
    CM_ToMy_data* data=[CM_ToMy_data mj_objectWithKeyValues:dataDit];
 
    NSMutableArray* m_arr=[[NSMutableArray alloc]init];
    
    for (NSArray* arr in data.comments) {
        CM_ToMy_comments* comment=[CM_ToMy_comments mj_objectWithKeyValues:arr];
        CM_ToMy_user* user=[CM_ToMy_user mj_objectWithKeyValues:comment.user];
        CM_ToMy_status* status=[CM_ToMy_status mj_objectWithKeyValues:comment.status];
        CM_ToMy_stutasUser* statusUser=[CM_ToMy_stutasUser mj_objectWithKeyValues:status.user];
        NSString* string=[comment.source stringByReplacingOccurrencesOfString:@">" withString:@"<"];
        NSArray* arr=[string componentsSeparatedByString:@"<"];

        NSDictionary* dic=[[NSDictionary alloc]initWithObjectsAndKeys:comment.text,@"comment.text",arr[arr.count/2],@"comment.source",comment.created_at,@"comment.created_at",user.name,@"comment.user.name",user.profile_image_url,@"comment.user.profile_image_url",status.text,@"commment.status.text",statusUser.name,@"comment.status.user.name",statusUser.profile_image_url,@"comment.status.user.profile_image_url", nil];
        [m_arr addObject:dic];
        
    }
    //各个网络的数据获取已经完成，接下来就是把他返回去一个方便使用的数组
    //数据获取。
    return m_arr;
    
}
@end
