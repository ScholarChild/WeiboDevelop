/* 
 考虑点：
    1，数据格式,
    2，图片是已有的 还是获取来的 
        获取来的传入的就是imageName：,已有的要么一直显示，要么要显示时判断bool
    3，
*/

#import <UIKit/UIKit.h>

@interface UserInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *dataDic;
- (void)initBodySubviews;
- (void)initHeadSubviews;
- (void)initNeckSubviews;
@end
