//
//  UserHeaderView.h
//  WeiBo
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBUser.h"
@interface UserHeaderView : UIView

@property(nonatomic,strong)WBUser *userData;

- (void)initSubview;
@end
