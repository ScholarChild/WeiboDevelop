#import <Foundation/Foundation.h>
#import "WBRequestManager.h"
#import "WBUser.h"
@interface DataManager : NSObject
+ (WBUser *)dataJson:(NSString *)name;

+ (NSArray *)getPlistDataWithName:(NSString *)plistName;

@end
