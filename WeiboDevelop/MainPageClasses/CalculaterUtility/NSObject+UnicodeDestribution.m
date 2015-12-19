//
//  NSObject+UnicodeDestribution.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/19.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "NSObject+UnicodeDestribution.h"
#import <objc/runtime.h>

@implementation NSObject (UnicodeDestribution)



- (NSString *)UnicodeDescription
{
    NSString* desc = [self description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}


@end
