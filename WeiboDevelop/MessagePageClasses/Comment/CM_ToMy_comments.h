//
//  CM_ToMy_comments.h
//  测试微博开发
//
//  Created by Ibokan on 15/12/5.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface CM_ToMy_comments : NSObject
@property(nonatomic,copy)NSString* text;
@property(nonatomic,copy)NSString* created_at;
@property(nonatomic,copy)NSString* source;
@property(nonatomic,copy)NSDictionary* user;
@property(nonatomic,copy)NSDictionary* status;
@end
