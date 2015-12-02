#import "ArrInfo.h"

@implementation ArrInfo

+ (NSMutableArray *)getPlistArr:(NSString *)plistName
{
    NSMutableArray * dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];

    return dataArr;
}


+ (NSArray *)getPlistArrInPhone:(NSString *)plistName
{
    NSArray * dataArr = [[NSArray alloc]initWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistName]]];
    return dataArr;
}


@end
