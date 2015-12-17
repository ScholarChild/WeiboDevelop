//
//  ActivityViewAction.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/14.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "ActivityViewAction.h"

@implementation ActivityViewAction


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //        背景View  为了防止,用户误操作.
        UIView * backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
         
        
        [self addSubview:backgroundView];
        
        UIView * loadingV = [[UIView alloc] initWithFrame:CGRectMake(120, 300, 100, 100)];
        
        loadingV.layer.cornerRadius = 10;
        
        loadingV.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
        [self addSubview:loadingV];
        //      小菊花  (考究：它的宽高是多少.37,37)
        _activityV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityV.color=[UIColor blackColor];
        _activityV.center = CGPointMake(50, 40);
        
        [loadingV addSubview:_activityV];
        
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 80, 30)];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment= NSTextAlignmentCenter;
        [loadingV addSubview:_textLabel];
        self.alpha=0;
    }
    return self;
}
-(void)showWithText:(NSString *)showText
{
    if (self.alpha == 0)//包含了,self.hidden == YES
    {
        self.alpha = 1.0;
        _textLabel.text = showText;
        [_activityV startAnimating];
    }
}
-(void)hidden
{
    self.alpha = 0.0;
    [_activityV stopAnimating];
    _textLabel.text = @"";
}




@end
