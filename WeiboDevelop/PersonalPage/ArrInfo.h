#import <Foundation/Foundation.h>

@interface ArrInfo : NSObject
+ (NSArray *)getPlistArr:(NSString *)plistName;
+ (NSArray *)getPlistArrInPhone:(NSString *)plistName;
@end
