#import "DataManager.h"


@implementation DataManager

+ (NSMutableArray *)getPlistDataWithName:(NSString *)plistName
{
    NSMutableArray * dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];

    return dataArr;
}
+ (WBUser *)dataJson:(NSString *)name
{
    //
    WBURLAnalyser *analyser = [WBURLAnalyser new];
    WBUser * userData = [analyser userInfoWithUserName:@"真小寒"];
   
    return userData;
}




@end
