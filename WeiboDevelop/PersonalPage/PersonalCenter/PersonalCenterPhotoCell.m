//
//  PersonalCenterCell.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/2.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "PersonalCenterPhotoCell.h"

@implementation PersonalCenterPhotoCell

- (void)addPhotoWithArray:(NSDictionary *)photoDic
{
    NSArray *keys = [photoDic allKeys];
    int x;
    int y = 0;
    for (int i = 0; i < keys.count ; i++) {
        x = i;
        if (i > 2) {
            x = 0;

            y++;
        }
        NSString *imageName = [photoDic objectForKey:[keys objectAtIndex:i]];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10+x * [UIScreen mainScreen].bounds.size.width / 3.0, 5 + y * 80, [UIScreen mainScreen].bounds.size.width / 3.0-10, 70)];
        imgV.image = [UIImage imageNamed:imageName];
        [self addSubview:imgV];
        
    }
}

@end
