//
//  CommentTableViewCell.h
//  测试微博开发
//
//  Created by Ibokan on 15/12/4.
//  Copyright (c) 2015年 eoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,assign)NSInteger height;
-(void)dicWithComment:(NSDictionary*)dic;
@end
