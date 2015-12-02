//
//  InfoManager.h
//  DZWeibo
//
//  Created by Ibokan on 15/10/15.
//  Copyright (c) 2015年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"
#import "WBStatus.h"

@interface WBURLAnalyser : NSObject


- (NSArray*)latestStatuses;
- (NSArray*)latestStatusesWithCount:(NSInteger)count;

- (WBUser*)userInfoWithUserName:(NSString*)userName;


@end
