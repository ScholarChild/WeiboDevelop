#import "FindPageTableViewCell.h"
#import "FindPageNewsVIew.h"
#define CellWidth [UIScreen mainScreen].bounds.size.width

@interface FindPageTableViewCell()
{
    UIScrollView *headSV;
    UIPageControl * pageControl;
    
    NSString *news1Text;
    NSTimer *_timer;
    
    
}
@end
@implementation FindPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 数组没值 可能性是每初始化数组;
        _popularizeImgNameArr = [NSMutableArray arrayWithCapacity:4];
        _newsArr = [NSMutableArray arrayWithCapacity:4];
        _recommended = YES;
    }
    return self;
}
- (void)setHeadCell
{
    headSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CellWidth, 80)];
    headSV.backgroundColor = [UIColor cyanColor];
    headSV.contentSize = CGSizeMake(CellWidth * _adCount, 80);
    headSV.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < _adCount; i++) {
        UIImageView *imgV = [UIImageView new];
         imgV.frame = CGRectMake(i*CellWidth, 0, CellWidth, 80);
        imgV.image = [UIImage imageNamed:[_popularizeImgNameArr objectAtIndex:i]];
        imgV.userInteractionEnabled = YES;
        
        [headSV addSubview:imgV];
    }
    headSV.bounces = NO;
    headSV.pagingEnabled = YES;
    headSV.delegate = self;
    [self addSubview:headSV];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CellWidth - 100,80 - 30, 60, 30)];
    pageControl.numberOfPages = _adCount;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
}

- (void)setNeckCell
{
    FindPageNewsVIew *view = [FindPageNewsVIew new];
    view.frame = CGRectMake(0, 0, CellWidth, 80);
    view.backgroundColor =[UIColor whiteColor] ;
    for (int i = 0; i < 4; i++) {
        int j = i;
        UIButton *btnTmp = [UIButton buttonWithType:UIButtonTypeRoundedRect];

        [btnTmp setBackgroundImage:[UIImage imageNamed:@"btn_gray_backgroud.png"] forState:UIControlStateHighlighted];
        if (i < 2) {
            btnTmp.frame = CGRectMake(i*CellWidth/2.0, 0, CellWidth/2.0, 80/2.0);
        }
        else{
            j-=2;
            btnTmp.frame = CGRectMake(j*CellWidth/2.0, 80/2.0, CellWidth/2.0, 80/2.0);
        }
        [view addSubview:btnTmp];
      
        btnTmp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        btnTmp.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 30);
 
        [btnTmp setTintColor:[UIColor blackColor]];
        btnTmp.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btnTmp.titleLabel.font = [UIFont systemFontOfSize:17.0];
        
        [btnTmp setTitle:[_newsArr objectAtIndex:i] forState:UIControlStateNormal];
        //        btnTmp.titleLabel.text =  [_newsArr objectAtIndex:i];
    }

    if (self.recommended) {
        
        CGRect nameRect = [[_newsArr objectAtIndex:0] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,25) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
        if (nameRect.size.width > 145) {
            nameRect.size.width = 115;
        }
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(nameRect.size.width+30+10,11, 15, 18)];
        imgV.image = [UIImage imageNamed:@"findpage_recommend.png"];
        [view addSubview:imgV];
    }
    [self addSubview:view];
}
- (void)timeRun
{
    CGPoint offset = headSV.contentOffset;
    offset.x += headSV.frame.size.width;
    if (offset.x == headSV.contentSize.width) {
        offset.x = 0;
    }
    headSV.contentOffset = offset;
    pageControl.currentPage = offset.x/headSV.frame.size.width;
}
- (void)addBtnTarget:(id)target action:(SEL)action
{
    NSArray* subviews = [[[self subviews] objectAtIndex:1] subviews];
    for (UIView* view in subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton* btn = (UIButton*)view;

            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)imgAction:(id)target action:(SEL)action
{
    NSArray* subviews = [[[self subviews] objectAtIndex:1] subviews];
    for (UIView* view in subviews) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            UIImageView* imgV = (UIImageView*)view;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
            [imgV addGestureRecognizer:tap];
        }
    }
    
}

@end
