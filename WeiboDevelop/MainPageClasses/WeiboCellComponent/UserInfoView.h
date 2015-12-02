//
//  BaseInfoView.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView

- (void)setAvatarImgWithURL:(NSURL*)imgURL;

- (void)setUserName:(NSString*)userName;
- (void)setCreateTime:(NSString*)createTime;
- (void)setSource:(NSString*)source;



@end
