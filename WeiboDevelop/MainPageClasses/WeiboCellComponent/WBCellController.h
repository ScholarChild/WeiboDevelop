//
//  WeiboViewFactory.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBContainCell.h"
#import "WBStatus.h"
#import "WBUser.h"

#import "UserInfoView.h"
#import "BodyView.h"
#import "CellToolBar.h"

typedef NS_ENUM(NSInteger, WBContextCellMode) {
    WBContextCellModeDefault,
    WBContextCellModeNoToolBar,
};

//typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
//    UITableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
//    UITableViewCellStyleValue1,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
//    UITableViewCellStyleValue2,		// Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts)
//    UITableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
//};


@interface WBCellController : UIViewController

@property (nonatomic,readonly)CGFloat heightOfCell;
@property (nonatomic,retain)WBStatus* status;

- (instancetype)initWithStatus:(WBStatus*)status;
- (void)constructCell:(WBContainCell*)cell mode:(WBContextCellMode)constructMode;

@end
