#import "AppDelegate.h"
#import "HomePageController.h"
#import "MessagePageController.h"
#import "FindViewController.h"
#import "PersonalPageController.h"

#import "MainMenuController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//add to test 


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HomePageController* home=[HomePageController new];
    //TabBar按钮的名字
//    home.tabBarItem.title=@"主页";
//    home.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_home" ofType:@"png" ]];
//    UINavigationController* homeNavi = [[UINavigationController alloc]initWithRootViewController:home];
//    
//    
//    MessagePageController* message=[MessagePageController new];
//    message.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_message" ofType:@"png" ]];
//    message.tabBarItem.title=@"消息";
//    UINavigationController *messageNavi=[[UINavigationController alloc]initWithRootViewController:message];
//    
//    
//    FindViewController* findView = [FindViewController new];
//    UINavigationController *findNavi = [[UINavigationController alloc] initWithRootViewController:findView];
//    findView.tabBarItem.title=@"搜索";
//    findView.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_search_n" ofType:@"png" ]];
//    
//    PersonalPageController* personal=[PersonalPageController new];
//    personal.tabBarItem.title=@"个人信息";
//    personal.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_selfinfo" ofType:@"png" ]];
//    UINavigationController* personalNavi = [[UINavigationController alloc]initWithRootViewController:personal];
//    
//    MainMenuController* mainMenu=[MainMenuController new];
//
//    mainMenu.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_more" ofType:@"png" ]];
//    
//    UITabBarController* tabBarC =[UITabBarController new];
//    //    传入数组。数组元素是各个视图控制器对象
//   
//    tabBarC.viewControllers=@[homeNavi,messageNavi,mainMenu,findNavi,personalNavi];
//    //    设置被选中的视图控制器
//    tabBarC.selectedViewController=homeNavi;
//    //默认选中
//
//    tabBarC.selectedIndex=0;
//    //选中时的颜色
//    tabBarC.tabBar.tintColor=[UIColor orangeColor];
//    //背景颜色
//    tabBarC.tabBar.barTintColor=[UIColor whiteColor];
    
    self.window.rootViewController = home;


    return YES;
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
