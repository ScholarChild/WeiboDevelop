//
//  BodyView.h
//  WeiboMainPage
//
//  Created by Ibokan on 15/11/25.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageContext.h"
#import "LayoutHeight.h"

@interface BodyView : UIView<LayoutHeight>

@property(nonatomic,readonly)CGFloat height;

- (void)setBodyText:(NSString *)text;
- (void)setBodyText:(NSString *)text URLOfImagesAtBody:(NSArray*)urlArray;
- (void)setBodyText:(NSString *)text retweetText:(NSString*)retweetText retweetUser:(NSString*)userName;
- (void)setBodyText:(NSString *)text retweetText:(NSString*)retweetText retweetUser:(NSString*)userName imagesAtRetweetBody:(NSArray*)urlArray;

@end
