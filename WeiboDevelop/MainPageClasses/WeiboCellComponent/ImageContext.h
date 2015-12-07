//
//  ImageContext.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/27.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyView.h"
#import "LayoutHeight.h"

@interface ImageContext : UIView<LayoutHeight>

@property(nonatomic,readonly)CGFloat height;

- (void)setImagesWithUrlArr:(NSArray*)urlArray;

@end

