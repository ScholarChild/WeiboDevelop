//
//  HotWeiboCatalogueView.h
//  WeiboFind
//
//  Created by ibokan on 15/11/26.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotWeiboCatalogueView : UIView

@property(strong)UIView *whiteview;
@property(strong)UIScrollView *bodyScroll;
@property(strong)UIView *personalCatalogueView;
@property(strong)UILabel *addlabel;
@property(strong)UIView *addCalalogueView;

- (instancetype)init;

- (void)initWithPersonalCatalogue;

- (void)initWithAddCalalogue;

@end
