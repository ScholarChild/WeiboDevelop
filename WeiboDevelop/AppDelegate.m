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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    HomePageController* home=[HomePageController new];
    //TabBar按钮的名字
    home.tabBarItem.title=@"主页";

//    home.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tabbar_home@2x" ofType:@"png" ]];
//    imageName的方式会在使用的时候系统会cache，程序员是无法处理cache的，这是由系统自动处理的，对于重复加载的图像，速度会提升很多，这样反而用户体验好。所以如果某张图片需要在应用中使用多次，或者重复引用，使用imageName的方式会更好
    home.tabBarItem.image=[UIImage imageNamed:@"tabbar_home@2x.png"];
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected@2x.png"];
    UINavigationController* homeNavi = [[UINavigationController alloc]initWithRootViewController:home];

    MessagePageController* message=[MessagePageController new];
    message.tabBarItem.image= [UIImage imageNamed:@"tabbar_message_center@2x.png"];
    message.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected@2x.png"];
    message.tabBarItem.title=@"消息";
    UINavigationController *messageNavi=[[UINavigationController alloc]initWithRootViewController:message];
    
    
    FindViewController* findView = [FindViewController new];
    UINavigationController *findNavi = [[UINavigationController alloc] initWithRootViewController:findView];
    findView.tabBarItem.title=@"发现";
    findView.tabBarItem.image=[UIImage imageNamed:@"tabbar_discover@2x.png"];
    findView.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_highlighted@2x.png"];
    
    PersonalPageController* personal=[PersonalPageController new];
//<<<<<<< Updated upstream
    personal.tabBarItem.title=@"个人信息";
    personal.tabBarItem.image=[UIImage imageNamed:@"tabbar_profile@2x.png"];
    personal.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_highlighted@2x.png"];
//=======
//    personal.tabBarItem.title=@"我";
//    personal.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_selfinfo" ofType:@"png" ]];
//>>>>>>> Stashed changes
    UINavigationController* personalNavi = [[UINavigationController alloc]initWithRootViewController:personal];
    
    MainMenuController* mainMenu=[MainMenuController new];
//<<<<<<< HEAD
//
//<<<<<<< Updated upstream
//    mainMenu.tabBarItem.image=[[UIImage alloc]init];
//=======
//    mainMenu.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"icon_more" ofType:@"png" ]];
//=======
   
//    mainMenu.tabBarItem.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@" " ofType:@"png" ]];
//>>>>>>> message
//>>>>>>> Stashed changes
    
    UITabBarController* tabBarC =[UITabBarController new];
    //    传入数组。数组元素是各个视图控制器对象
   
    tabBarC.viewControllers=@[homeNavi,messageNavi,mainMenu,findNavi,personalNavi];
    //    设置被选中的视图控制器
    tabBarC.selectedViewController=homeNavi;
    //默认选中

    tabBarC.selectedIndex=0;
    //选中时的颜色
    tabBarC.tabBar.tintColor=[UIColor orangeColor];
    //背景颜色
//<<<<<<< HEAD
//    tabBarC.tabBar.barTintColor=[UIColor whiteColor];
//    
//=======
    tabBarC.tabBar.barTintColor=[UIColor blackColor];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(self.window.frame.size.width*2/5,0, self.window.frame.size.width/5, 48)];
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [tabBarC.tabBar addSubview:btn];
//>>>>>>> message
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
