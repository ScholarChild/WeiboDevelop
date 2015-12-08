//
//  CommentToMyTableViewCell.m
//  测试微博开发
//
//  Created by Ibokan on 15/12/7.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import "CommentToMyTableViewCell.h"
#define textFont [UIFont systemFontOfSize:12]
@interface CommentToMyTableViewCell()
{
    UIImageView* imgView;
    UILabel* nameLable;
    UILabel* timeLable;
    UILabel* sourceLable;
    UILabel* textLable;
    UIView*view;
}
@end
@implementation CommentToMyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imgView=[UIImageView new];
        [self addSubview:imgView];
        nameLable=[UILabel new];
        [self addSubview:nameLable];
        textLable=[UILabel new];
        [self addSubview:textLable];
        sourceLable=[UILabel new];
        [self addSubview:sourceLable];
        timeLable=[UILabel new];
        [self addSubview:timeLable];
        view=[[UIView alloc]init];
        [self addSubview:view];
    }
    return self;
}
 
-(void)arrayTableViewCell:(NSDictionary *)dic endIma:(UIImage*)image endImage:(UIImage*)image1{
   
    
    imgView.frame=CGRectMake(10, 10, 40, 40);
    imgView.image=image;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0;
    imgView.layer.masksToBounds = YES;
    
    CGFloat imgViewX=CGRectGetMaxX(imgView.frame)+10;
    nameLable.frame=CGRectMake(imgViewX,10,100,20);
    nameLable.text=[dic objectForKey:@"comment.user.name"];
    nameLable.font=textFont;
    
    CGFloat nameLabelY=CGRectGetMaxY(nameLable.frame);
    timeLable.text=[dic objectForKey:@"comment.created_at"];
    timeLable.frame=CGRectMake(imgViewX, nameLabelY, 100, 20);
    timeLable.font=[UIFont systemFontOfSize:10];
    timeLable.textColor=[UIColor lightGrayColor];
    
    CGFloat timeLabelX=CGRectGetMaxX(timeLable.frame)+5;
    sourceLable.frame=CGRectMake(timeLabelX, nameLabelY, 100, 20);
    sourceLable.text=[dic objectForKey:@"comment.source"];
    sourceLable.font=[UIFont systemFontOfSize:10];
    sourceLable.textColor=[UIColor lightGrayColor];
    
    CGFloat imgViewY=CGRectGetMaxY(imgView.frame);
    textLable.numberOfLines=0;
    textLable.text=[dic objectForKey:@"comment.text"];
    CGSize textSize=[textLable sizeThatFits:CGSizeMake(self.frame.size.width-10, CGFLOAT_MAX)];
    textLable.frame=CGRectMake(10, imgViewY, textSize.width, textSize.height);
    textLable.font=textFont;
    
    
    CGFloat textLableY=CGRectGetMaxY(textLable.frame)+10;
    view.frame=CGRectMake(10, textLableY, self.frame.size.width+20,60);
    view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    UIImageView* imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60,60)];
    imgView1.image=image1;
    [view addSubview:imgView1];
    UILabel* viewNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70,0, 100, 20)];
    viewNameLabel.font=textFont;
    viewNameLabel.text=[NSString stringWithFormat:@"@%@",[dic objectForKey:@"comment.status.user.name"]];
    [view addSubview:viewNameLabel];
    
    UILabel* viewTextLable=[[UILabel alloc]init];
    viewTextLable.numberOfLines=2;
     viewTextLable.text=[dic objectForKey:@"commment.status.text"];
    CGSize viewTextSize=[viewTextLable sizeThatFits:CGSizeMake(self.frame.size.width-10-imgViewX, 30)];
    viewTextLable.frame=CGRectMake(70, 20, viewTextSize.width, viewTextSize.height);
    viewTextLable.font=[UIFont systemFontOfSize:10];
    viewTextLable.textColor=[UIColor lightGrayColor];
    [view addSubview:viewTextLable];
    
    self.heightY=CGRectGetMaxY(view.frame)+10;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
