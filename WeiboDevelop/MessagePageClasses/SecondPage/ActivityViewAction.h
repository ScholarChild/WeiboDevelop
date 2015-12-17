//
//  ActivityViewAction.h
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/14.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewAction : UIView
{
    UIActivityIndicatorView * _activityV;
    UILabel * _textLabel;
}

//显示文本和小菊花.
-(void)showWithText:(NSString *)showText;


-(void)hidden;

@end
