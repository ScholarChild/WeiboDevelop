//
//  Geo.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/29.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WBDataObject.h"



@interface WBGeo : WBDataObject

//@property (nonatomic,retain)NSString* ngitude;//经度坐标
//@property (nonatomic,retain)NSString* latitude;//维度坐标
//@property (nonatomic,retain)NSString* city;//所在城市的城市代码
//@property (nonatomic,retain)NSString* province;//所在省份的省份代码
//@property (nonatomic,retain)NSString* city_name;//所在城市的城市名称
//@property (nonatomic,retain)NSString* province_name;//所在省份的省份名称
//@property (nonatomic,retain)NSString* address;//所在的实际地址，可以为空
//@property (nonatomic,retain)NSString* pinyin;//地址的汉语拼音，不是所有情况都会返回该字段
//@property (nonatomic,retain)NSString* more;//更多信息，不是所有情况都会返回该字段

@property (nonatomic,retain)NSString* type;
@property (nonatomic,assign)CGPoint   coordinates;


@end
