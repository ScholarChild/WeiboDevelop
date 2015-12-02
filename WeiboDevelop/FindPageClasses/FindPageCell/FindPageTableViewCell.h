#import "UserInfoTableViewCell.h"

// 一种是先有数据在排版
@interface FindPageTableViewCell : UserInfoTableViewCell<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *popularizeImgNameArr;

@property(nonatomic,strong)NSMutableArray *newsArr;

// 是否显示推荐icon 
@property(nonatomic,assign)BOOL recommended;

@property(nonatomic,assign)NSInteger adCount;
@property(nonatomic,strong)NSDictionary *headDataDic;
@property(nonatomic,strong)NSDictionary *neckDataDic;

@end
