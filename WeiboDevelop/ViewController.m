 
#import "ViewController.h"
#import "MyButton.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
@interface ViewController (){
    NSArray* _arr;
    int tag;
}
@property(strong,nonatomic) UIView *tabbarView;//自定义个底部的tabbar视图
@property(strong,nonatomic)UIView * popView;//点击"+"号弹出的视图,高斯模糊效果
@end

@implementation ViewController

//模仿新浪微博的tabbar
//使用方法,通过storyboard拖拽一个tabbarViewController之后绑定该类即可

- (void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
//<<<<<<< HEAD
//    // Do any additional setup after loading the view, typically from a nib.
//
//=======
    NSBundle* boule=[NSBundle mainBundle];
    NSString* path=[boule pathForResource:@"tarBar" ofType:@"plist"];
    _arr=[[NSArray alloc]initWithContentsOfFile:path];//从plist文件里获取数据
    
    
    [self configPopView];
    self.popView.alpha=0;
    [self.view addSubview:self.popView];//可以自定义一些控件加上动画的效果
    
   
 
    
}

#pragma mark - 初始化弹出的视图
- (void)configPopView
{
    UIScreen *s=[UIScreen mainScreen];
    CGFloat wid=[s bounds].size.width;
    CGFloat height=[s bounds].size.height;
    //点击中间的按钮弹出一个视图,是自定义的
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wid, height)];
    self.popView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    //微博文字图片
    UIImageView* imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weiboText.png"]];
    imgView.frame=CGRectMake(120, 100, 160, 100);
    [self.popView addSubview:imgView];
    //加载自己定义的button
    self.btnView=[[UIView alloc]initWithFrame:CGRectMake(0,Height,Width, 250)];
    self.btnView.tag=10001;
    [self.popView addSubview:self.btnView];
    [self MyButton:self.btnView];
    //底部的关闭按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, height-48, wid, 48);
    [button setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
    [button addTarget:self action:@selector(tapX:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=3333;
    [self.popView addSubview:button];
    
    
}
#pragma mark 加载自定义按钮方法
-(void)MyButton:(UIView*)view{
    
    for(int i=0;i<2;i++){
        for (int j=0; j<3; j++) {
            NSArray *arr=_arr[3*i+j+1];
            MyButton* btn=[[MyButton alloc]initWithFrame:CGRectMake(38+(80+30)*j,10+(30+80)*i , 80, 80)];
            [btn myViewImg:[UIImage imageNamed:arr[0] ] endText:arr[1]];
            [btn addTarget:self action:@selector(myBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=3*i+j;
            [view addSubview:btn];
        }
    }
}
#pragma mark 自定义按钮触碰方法
-(void)myBtnAction:(UIButton*)btn{
    
}

#pragma mark 按钮动画播放
-(void)btnAnimation{
    UIView* view=(UIView*)[self.view viewWithTag:10001];
    
    [UIView beginAnimations:@"showBtnImg" context:nil];
    [UIView setAnimationDuration:0.25];
    if (view.frame.origin.y!=Height/2) {
        view.frame=CGRectMake(0,Height/2,Width, 250);
    }
    else {
        view.frame=CGRectMake(0,Height,Width, 250);
        
    }
    [UIView setAnimationDelegate:self];
    
}
#pragma mark UIView的动画播放
-(void)animationAction{
    [UIView beginAnimations:@"ShowView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    if (self.popView.alpha==0) {
        self.popView.alpha=1;
    }else{
        self.popView.alpha=0;
    }
    
    
}
#pragma mark - 点击弹出的视图上的关闭按钮
-(void)tapX:(UIButton*)btn
{
    btn.userInteractionEnabled = NO;
    
    
    [self btnAnimation];
    [UIView setAnimationDidStopSelector:@selector(viewAnimationStop:finish:context:)];
    [UIView commitAnimations];
    //防止重复点击
    [self performSelector:@selector(delayMethod:) withObject:btn afterDelay:1];
}
//延迟方法->设置按钮为可点击状态
- (void)delayMethod:(UIButton *)button
{
    button.userInteractionEnabled = YES;
}


#pragma mark 当点击X按钮时触发动画结束
-(void)viewAnimationStop:(NSString *)animationID finish:(NSNumber *)finish context:(void *)context
{
    if ([animationID isEqualToString:@"showBtnImg"]) {
        [self finishView];
    }
 
//>>>>>>> message
}

#pragma mark 移除遮盖视图
-(void)finishView{
    //1.移除当前遮盖视图
    UIView* view=(UIView*)[self.view viewWithTag:10001];
    view.frame=CGRectMake(0,Height,Width, 250);//避免出现BUG
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
