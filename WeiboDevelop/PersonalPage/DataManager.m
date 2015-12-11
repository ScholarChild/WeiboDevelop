#import "DataManager.h"


@implementation DataManager

+ (NSMutableArray *)getPlistDataWithName:(NSString *)plistName
{
    NSMutableArray * dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];

    return dataArr;
}
+ (WBUser *)dataJson
{
    //
    WBRequestManager *analyser = [WBRequestManager new];
    WBUser * userData = [analyser personalInfoWithUserName:PersonalUserName];
   
    return userData;
}




@end
