//
//  PersonalCenterDataManager.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/2.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "PersonalCenterDataManager.h"

@implementation PersonalCenterDataManager
+ (NSArray *)getPersonalInfoData
{
    NSArray* firstArr = @[@"所在地 广东",@"更多基本资料"];
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        [arr addObject:[NSString stringWithFormat:@"第%d条微博",i]];
    }
    NSArray *  dataArr = @[firstArr,arr];
    return dataArr;
}
+ (NSArray *)getWBStatusData
{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 30; i++) {
        [arr addObject:[NSString stringWithFormat:@"第%d条微博",i]];
    }
    NSArray *  dataArr = @[arr];
    return dataArr;
}
+ (NSArray *)getPersonalPhotoesData
{
    NSString *str = @"advertisement1.png";
    NSString *str1 = @"advertisement2.png";
    NSString *str2 = @"advertisement3.png";
     NSString *str3 = @"advertisement4.png";

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"photo1",str1,@"photo2",str2,@"photo3",str3,@"photo4" ,nil];
    NSArray *arr = @[dic];
    NSArray * dataArr = @[arr];
    return dataArr;
}
@end
