#import "FindPageTableViewCell.h"
#import "FindPageNewsVIew.h"
#define CellWidth [UIScreen mainScreen].bounds.size.width

@interface FindPageTableViewCell()
{
    UIScrollView *headSV;
    UIPageControl * pageControl;
    UIImageView *imageV1;
    UIImageView *imageV2;
    UIImageView *imageV3;
    UIImageView *imageV4;
    
    UIButton *newsBtn1;
    UIButton *newsBtn2;
    UIButton *newsBtn3;
    UIButton *newsBtn4;
    
    FindPageNewsVIew *view;
    NSString *news1Text;
    NSTimer *_timer;
    
    
}
@end
@implementation FindPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        _popularizeImgNameArr = [NSMutableArray arrayWithCapacity:4];
        _newsArr = [NSMutableArray arrayWithCapacity:4];
       
    }
    return self;
}
- (void)initHeadSubviews
{
    headSV = [[UIScrollView alloc]init];
    headSV.backgroundColor = [UIColor cyanColor];
    headSV.contentSize = CGSizeMake(CellWidth * 4, 80);
    headSV.showsHorizontalScrollIndicator = NO;
    headSV.frame = CGRectMake(0, 0, CellWidth, 80);
    
    imageV1 = [UIImageView new];
    imageV2 = [UIImageView new];
    imageV3 = [UIImageView new];
    imageV4 = [UIImageView new];
    NSArray *arr = @[imageV1,imageV2,imageV3,imageV4];
    for (int i = 0; i < 4; i++) {
        UIImageView *imgV = [arr objectAtIndex:i];
        imgV.frame = CGRectMake(i*CellWidth, 0, CellWidth, 80);
        imgV.userInteractionEnabled = YES;
        [headSV addSubview:imgV];
    }
    headSV.bounces = NO;
    headSV.pagingEnabled = YES;
    headSV.delegate = self;
    [self addSubview:headSV];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CellWidth - 100,80 - 30, 60, 30)];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
}
-(void)setHeadDataDic:(NSDictionary *)headDataDic
{
    imageV1.image = [UIImage imageNamed:[headDataDic objectForKey:@"image1"]];
    imageV2.image = [UIImage imageNamed:[headDataDic objectForKey:@"image2"]];
    imageV3.image = [UIImage imageNamed:[headDataDic objectForKey:@"image3"]];
    imageV4.image = [UIImage imageNamed:[headDataDic objectForKey:@"image4"]];
}

- (void)initNeckSubviews
{
    view = [FindPageNewsVIew new];
    view.frame = CGRectMake(0, 0, CellWidth, 80);
    view.backgroundColor =[UIColor whiteColor] ;
    newsBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newsBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newsBtn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newsBtn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSArray *arr = @[newsBtn1,newsBtn2,newsBtn3,newsBtn4];
    for (int i = 0; i < 4; i++) {
        int j = i;
        UIButton *btnTmp = [arr objectAtIndex:i];

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
       

    }
    [self addSubview:view];
}
-(void)setNeckDataDic:(NSDictionary *)neckDataDic
{
    [newsBtn1 setTitle:[neckDataDic objectForKey:@"news1"] forState:UIControlStateNormal];
     [newsBtn2 setTitle:[neckDataDic objectForKey:@"news2"] forState:UIControlStateNormal];
 [newsBtn3 setTitle:[neckDataDic objectForKey:@"news3"] forState:UIControlStateNormal];
     [newsBtn4 setTitle:[neckDataDic objectForKey:@"news4"] forState:UIControlStateNormal];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _recommended = YES;//暂定为yes
    if (self.recommended) {
        
        CGRect nameRect = [newsBtn1.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,25) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
        if (nameRect.size.width > 145) {
            nameRect.size.width = 115;
        }
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(nameRect.size.width+30+10,11, 15, 18)];
        imgV.image = [UIImage imageNamed:@"findpage_recommend.png"];
        [view addSubview:imgV];
    }
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}
@end
