//
//  EmoticonTransfer.h
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/18.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EmoticonTransfer : NSObject

+ (instancetype)shareTransfer;

- (NSString*)imageEmojiNamewithCode:(NSString*)code;

- (NSArray*)getAllEncodingEmoticonGroupName;
- (NSArray*)getAllImageEmoticonGroupName;

- (NSDictionary*)getImagaEmoticonListWithGroupName:(NSString*)groupName;
- (NSArray*)getEncodingEmoticonListWithGroupName:(NSString*)groupName;

@end
