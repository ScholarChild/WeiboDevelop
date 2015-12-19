//
//  EmoticonsView.m
//  UI_0.3
//
//  Created by Ibokan on 15/12/11.
//  Copyright (c) 2015年 LXF. All rights reserved.
//

#import "EmoticonsView.h"
#define Width  self.frame.size.width
#define Height self.frame.size.height

#define packageName @"com.sina.default"
#define bundlePath [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"]

@interface EmoticonsView(){
    NSArray * _face ;
    
    
}
@end
@implementation EmoticonsView
-(id)initWithNumber:(int)temp endBlock:(MyBlock)block
{
    if (self=[super init]) {
        NSString* infoDicPath = [NSString stringWithFormat:@"%@/%@/%@",bundlePath,packageName,@"info.plist"];
        NSDictionary * dic=[[NSDictionary alloc]initWithContentsOfFile:infoDicPath];
        self.block=block;
        //获取plist中的数据
        _face = [dic objectForKey:@"emoticons"];
        
        [self numberOne:temp];
    }
    return self;
}
-(void)numberOne:(int)tem{
    self.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
  
    for(int i=0;i<3;i++){
        for (int j =0; j<7; j++) {
            UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(50*j+20,50*i+20, 30, 30)];
            NSString* imgName = [NSString stringWithFormat:@"%@/%@/%@",
                                 bundlePath,packageName,_face[i*7+j+tem*20][@"png"]];
            UIImage* img=[UIImage imageNamed:imgName];
            [btn setImage:img forState:UIControlStateNormal];
            [btn setImage:img forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i*7+j+tem*20;
            [self addSubview:btn];
        }
    }
}
-(void)btnAction:(UIButton* )btn{
    if (self.block) {
        self.block(_face[btn.tag][@"chs"]);
    }
}
@end