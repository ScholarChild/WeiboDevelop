//
//  DateTransformer.m
//  WeiboMainPageReady
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "DateTransformer.h"

@implementation DateTransformer

+ (NSDate *)dateWithString:(NSString *)timeString format:(NSString *)dateFormat locale:(NSString *)localeIdentifier
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale* sourceLocate = [[NSLocale alloc]initWithLocaleIdentifier:localeIdentifier];
    [dateFormatter setLocale:sourceLocate];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:timeString];
}

+ (NSString *)timeIntervalStringForNowSinceDate:(NSDate *)oldDate
{
    NSString* timeString;
    NSDate* currentDate = [NSDate date];
    NSString* dateString = [oldDate descriptionWithLocale:nil];
    int timeInterval =  (int)[currentDate timeIntervalSinceDate:oldDate];
    NSString* oldDayString = [dateString substringWithRange:NSMakeRange(8, 2)];
    NSString* currDayString = [[currentDate descriptionWithLocale:nil] substringWithRange:NSMakeRange(8, 2)];
    NSInteger dayInterval = [currDayString integerValue] - [oldDayString integerValue];
    
    if (dayInterval >= 1) {
        if (dayInterval < 2) {
            timeString = [NSString stringWithFormat:@"昨天 %@",[dateString substringWithRange:NSMakeRange(11, 5)]];
        }else{
            timeString = [dateString substringWithRange:NSMakeRange(5, 5)];
        }
    }else{
        int hour = timeInterval / 3600;
        int min = (timeInterval % 3600) / 60;
        if (hour > 0) {
            timeString = [NSString stringWithFormat:@"%d小时前",hour];
        }else if(min > 0) {
            timeString = [NSString stringWithFormat:@"%d分钟前",min];
        }else{
            timeString = @"刚刚";
        }
    }
    
    return timeString;
}



@end
