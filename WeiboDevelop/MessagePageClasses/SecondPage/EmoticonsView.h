//
//  EmoticonsView.h
//  UI_0.3
//
//  Created by Ibokan on 15/12/11.
//  Copyright (c) 2015年 LXF. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyBlock)(NSString*);
@interface EmoticonsView : UIView
@property(copy,nonatomic)MyBlock block;
-(id)initWithNumber:(int)temp endBlock:(MyBlock)block;
@end
