#import "UserInfoTableViewCell.h"

@interface HomePageTableViewCell : UserInfoTableViewCell
@property(nonatomic,strong)UIButton *memberBtn;

@property(nonatomic,strong)NSMutableArray *userInfoNumArr;

@property(nonatomic,strong)NSString *userImageName;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userDetail;
@property(nonatomic,assign)int level;



- (void)addBtnTarget:(id)target action:(SEL)action;
@end
