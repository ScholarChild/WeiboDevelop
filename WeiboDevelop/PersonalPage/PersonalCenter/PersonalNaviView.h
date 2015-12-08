
#import <UIKit/UIKit.h>
#import "PersonalCenterProtocol.h"
@interface PersonalNaviView : UIView<PersonalCenterProtocol>

@property(nonatomic,strong)id<PersonalCenterProtocol>btnDelegate;


@end
