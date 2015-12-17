//
//  ButtomMenu.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickAction) (NSInteger count);

@interface CellToolBar : UIView

- (void)setRepostCount:(NSNumber *)repostCount;
- (void)setCommentCount:(NSNumber *)commentCount;
- (void)setAttitudeCount:(NSNumber *)attitudeCount;

@property (nonatomic,copy)clickAction repostAction;
@property (nonatomic,copy)clickAction commendAction;

@end
