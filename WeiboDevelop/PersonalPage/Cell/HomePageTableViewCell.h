#import "UserInfoTableViewCell.h"
#import "WBUser.h"
@interface HomePageTableViewCell : UserInfoTableViewCell
@property(nonatomic,strong)UIButton *memberBtn;

@property(nonatomic,strong)WBUser *headUserData;
@property(nonatomic,strong)WBUser *neckUserData;



@property(nonatomic,assign)int level;


@end
