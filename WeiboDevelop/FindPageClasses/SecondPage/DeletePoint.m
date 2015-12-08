//
//  DeletePoint.m
//  WeiboDevelop
//
//  Created by ibokan on 15/12/8.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "DeletePoint.h"

@implementation DeletePoint

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 10, 10);
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, 9, 9)];
        label.text = @"x";
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
