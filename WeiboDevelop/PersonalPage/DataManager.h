#import <Foundation/Foundation.h>
#import "WBURLAnalyser.h"
#import "WBUser.h"
@interface DataManager : NSObject
+ (WBUser *)dataJson;

+ (NSArray *)getPlistDataWithName:(NSString *)plistName;

@end
