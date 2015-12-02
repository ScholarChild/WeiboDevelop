//
//  Geo.m
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import "WBGeo.h"

@implementation WBGeo

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"coordinates"]) {
        NSArray* coordArr = (NSArray*)value;
        NSNumber* XNumber = (NSNumber*)coordArr[0];
        NSNumber* YNumber = (NSNumber*)coordArr[1];
        _coordinates = CGPointMake([XNumber floatValue], [YNumber floatValue]);
    }else {
        [super setValue:value forKey:key];
    }
}

@end
