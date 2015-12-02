#import "UserInfoTableViewCell.h"

// 一种是先有数据在排版
@interface FindPageTableViewCell : UserInfoTableViewCell<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *popularizeImgNameArr;

@property(nonatomic,strong)NSMutableArray *newsArr;

// 是否显示推荐icon 
@property(nonatomic,assign)BOOL recommended;

@property(nonatomic,assign)NSInteger adCount;
//@property(nonatomic,assign)BOOL timerClose;



- (void)addBtnTarget:(id)target action:(SEL)action;
- (void)imgAction:(id)target action:(SEL)action;
@end
