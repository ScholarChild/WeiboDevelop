//
//  MyButton.h
//  微博开发
//
//  Created by Ibokan on 15/12/2.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton
@property(nonatomic,retain)UIImageView* imgView;
@property(nonatomic,retain)UILabel*label;
-(void)myViewImg:(UIImage*)img endText:(NSString*)string;
@end
