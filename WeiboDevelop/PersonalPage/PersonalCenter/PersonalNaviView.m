#import "PersonalNaviView.h"
@interface PersonalNaviView()
{
    UIView *lineview;
    UIButton *_hpBtn;
    UIButton *_wbBtn;
    UIButton *_picBtn;
    NSArray *_btnArr;
}
@end
@implementation PersonalNaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [UIColor colorWithRed:((Byte)(0xF8F8FF >> 16))/255.0 green:((Byte)(0xF8F8FF >> 8))/255.0 blue:((Byte)0xF8F8FF)/255.0 alpha:1];
        [self initSubview];
    }
    return self;
}
- (void)initSubview;
{
    lineview= [UIView new];
    lineview.backgroundColor=[UIColor orangeColor];
    lineview.frame=CGRectMake(100,self.frame.size.height-2,50, 2);
    [self addSubview: lineview];
    
    _hpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _wbBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _picBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnArr = @[_hpBtn,_wbBtn,_picBtn];
    NSArray * arr1 = @[@"主页",@"微博",@"相册"];
    for (int i = 0; i< 3; i ++) {
        UIButton *btnTmp =  [_btnArr objectAtIndex:i];
        btnTmp.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width/6+100,0, 50, 38);
        btnTmp.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        [btnTmp setBackgroundImage:[UIImage imageNamed:@"btn_gray_backgroud.png"] forState:UIControlStateHighlighted];
        [btnTmp setTitle:[arr1 objectAtIndex:i] forState:UIControlStateNormal];
        btnTmp.tag = 1000+i;
        if (i == 0) {
            [btnTmp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [btnTmp setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        [btnTmp addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTmp];
    }
}

-(void)btnAction:(UIButton*)btn{
    for (int i = 0; i < 3; i++) {
        UIButton *btnTmp = (UIButton *)[self viewWithTag:1000+i];
        if ((int)btnTmp.tag == (int)btn.tag ) {
            [btnTmp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [UIView beginAnimations:@"frameChange" context:@"girl"];
            [UIView setAnimationDuration:0.3];
            CGRect rect = lineview.frame;
            rect.origin.x = btnTmp.frame.origin.x;
            lineview.frame = rect;
            [UIView commitAnimations];
            [_btnDelegate changeView:btn.tag-1000];
        }
        else{
            [btnTmp setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}

@end
