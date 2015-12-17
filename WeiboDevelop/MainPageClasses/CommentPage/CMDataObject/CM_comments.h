//
//  CM_comments.h
//  测试微博开发
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CM_user;
@interface CM_comments : NSObject
@property(nonatomic,copy)NSString* text;
@property(nonatomic,copy)NSString* created_at;
@property(nonatomic,retain)CM_user* user;
@end
