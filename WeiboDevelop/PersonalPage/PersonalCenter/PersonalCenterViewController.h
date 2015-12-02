#import <UIKit/UIKit.h>
#import "PersonalCenterProtocol.h"
#import "DataManager.h"
@interface PersonalCenterViewController : UIViewController<PersonalCenterProtocol>
@property(nonatomic,strong)WBUser *userData;
@end
