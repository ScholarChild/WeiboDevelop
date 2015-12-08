//
//  PersonalCenterDataManager.h
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/2.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenterDataManager : NSObject
+ (NSArray *)getPersonalInfoData;
+ (NSArray *)getWBStatusData;
+ (NSArray *)getPersonalPhotoesData;
@end
