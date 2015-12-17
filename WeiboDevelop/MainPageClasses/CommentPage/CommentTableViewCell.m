//
//  CommentTableViewCell.m
//  测试微博开发
//
//  Created by Ibokan on 15/12/4.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "CommentTableViewCell.h"
#define fontSize [UIFont systemFontOfSize:12]
@interface CommentTableViewCell()
{
    UIImageView* imgView;
    UILabel* name;
    UILabel* time;
    UILabel* text;
    

}
@end
@implementation CommentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        ui的初始化
        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        name=[[UILabel alloc]init];
        time=[[UILabel alloc]init];
        text=[[UILabel alloc]init];
        [self addSubview:imgView];
        [self addSubview:name];
        [self addSubview:time];
        [self addSubview:text];
        
    }
    return self;
    
}
 
-(void)dicWithComment:(NSDictionary *)dic
{
    NSString* string=[dic objectForKey:@"profile_image_url"];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    UIImage *image =[ UIImage imageWithData:data];
    imgView.image=image;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0;
    imgView.layer.masksToBounds = YES;
    
    CGFloat nameX=CGRectGetMaxX(imgView.frame)+10;
    name.frame=CGRectMake(nameX, 5,150,20);
    name.text=[dic objectForKey:@"name"];
    name.font=fontSize;
    
    CGFloat textY=CGRectGetMaxY(name.frame);
    time.frame=CGRectMake(nameX, textY , 150, 20 );
    time.text=[dic objectForKey:@"created_at"];
    time.font=[UIFont systemFontOfSize:10];
    time.textColor=[UIColor lightGrayColor];
    
    CGFloat timeY=CGRectGetMaxY(time.frame);
    text.numberOfLines=0;
    text.text=[dic objectForKey:@"text"];
     CGSize textSize=[text sizeThatFits:CGSizeMake(self.frame.size.width-10-10, CGFLOAT_MAX)];
    text.font=fontSize;
    text.frame=CGRectMake(nameX, timeY, textSize.width, textSize.height);
    
    

    CGFloat textX=CGRectGetMaxY(text.frame)+10;

    self.height=textX;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
