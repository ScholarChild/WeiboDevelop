//
//  DateTransformer.h
//  WeiboMainPageReady
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTransformer : NSObject

+ (NSDate*)dateWithString:(NSString*)timeString format:(NSString*)dateFormat locale:(NSString*)localeIdentifier;
+ (NSString*)timeIntervalStringForNowSinceDate:(NSDate*)oldDate;


@end
