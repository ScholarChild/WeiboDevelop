#import "AppDelegate.h"
#import "HomePageController.h"
#import "MessagePageController.h"
#import "FindViewController.h"
#import "PersonalPageController.h"

#import "MainMenuController.h"

#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//add to test 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HomePageController* home=[HomePageController new];
    //TabBar按钮的名字
    home.tabBarItem.title=@"主页";
    home.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_home" ofType:@"png" ]];
    UINavigationController* homeNavi = [[UINavigationController alloc]initWithRootViewController:home];
    
    
    MessagePageController* message=[MessagePageController new];
    message.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_message" ofType:@"png" ]];
    message.tabBarItem.title=@"消息";
    UINavigationController *messageNavi=[[UINavigationController alloc]initWithRootViewController:message];
    
    
    FindViewController* findView = [FindViewController new];
    UINavigationController *findNavi = [[UINavigationController alloc] initWithRootViewController:findView];
    findView.tabBarItem.title=@"搜索";
    findView.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_search_n" ofType:@"png" ]];
    
    PersonalPageController* personal=[PersonalPageController new];
    personal.tabBarItem.title=@"我";
    personal.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_selfinfo" ofType:@"png" ]];
    UINavigationController* personalNavi = [[UINavigationController alloc]initWithRootViewController:personal];
    
    MainMenuController* mainMenu=[MainMenuController new];
   
    mainMenu.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@" " ofType:@"png" ]];
    
    UITabBarController* tabBarC =[UITabBarController new];
    //    传入数组。数组元素是各个视图控制器对象
    tabBarC.viewControllers=@[homeNavi,messageNavi,mainMenu,findNavi,personalNavi];
    //    设置被选中的视图控制器
    tabBarC.selectedViewController=homeNavi;
    //默认选中
    tabBarC.selectedIndex=1;
    //选中时的颜色
    tabBarC.tabBar.tintColor=[UIColor orangeColor];
    //背景颜色
    tabBarC.tabBar.barTintColor=[UIColor blackColor];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(self.window.frame.size.width*2/5,0, self.window.frame.size.width/5, 48)];
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [tabBarC.tabBar addSubview:btn];
    self.window.rootViewController = tabBarC;

    return YES;
}
-(void)btnAction{
    ViewController* view=[[ViewController alloc]init];
    [view setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.window.rootViewController presentViewController:view animated:NO completion:^(){
        [view animationAction];//播放View动画
        [UIView commitAnimations];//结束动画
        [view btnAnimation];
        [UIView commitAnimations];
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
