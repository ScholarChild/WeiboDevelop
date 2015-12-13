#import <Foundation/Foundation.h>
#import "WBRequestManager.h"
#import "WBUser.h"
@interface DataManager : NSObject
+ (WBUser *)dataJson;

+ (NSArray *)getPlistDataWithName:(NSString *)plistName;

@end
