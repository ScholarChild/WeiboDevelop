//
//  ToData.h
//  微博开发1
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToData :NSObject
@property(nonatomic,copy)NSString* next_cursor;
@property(nonatomic,copy)NSString* previous_cursor;
@property(nonatomic,copy)NSString* total_number;
@property(nonatomic,retain)NSArray* users;
@end
