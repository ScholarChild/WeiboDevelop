//
//  TextAttributeTranster.h
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextAttributeTransfer : NSObject

@property (readonly)NSAttributedString* attrubuteText;

- (instancetype)initWithString:(NSString* )string fontSize:(CGFloat)size;

@end
