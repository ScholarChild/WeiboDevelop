#import "HomePageTableViewCell.h"

#define lineSpace 10.0 //间距
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface HomePageTableViewCell()
{
    UIImageView *_userImageView;
    UILabel *_userNameLabel;
    UILabel *_userDetailLabel;
    
    UILabel *_wbNumLabel;
    UILabel *_attentionNumLabel;
    UILabel *_fansNumLabel;
}
@end
@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _userInfoNumArr = [NSMutableArray arrayWithCapacity:3];
        
        _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return self;
}

- (void)setHeadCell
{
    _userImageView = [UIImageView new];
    _userNameLabel = [UILabel new];
    _userDetailLabel= [UILabel new];
    _userImageView.frame = CGRectMake(10, 10, 60, 60);//rowheight =80
    
    NSString *picStr= _userImageName;
    NSData *picData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picStr]];
    _userImageView.image = [UIImage imageWithData:picData];
    _userImageView.layer.cornerRadius=_userImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds=YES;
    _userNameLabel.text = _userName;
    CGRect nameRect = [_userNameLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];//17.0为系统字体大小，根据大小来断_userNameLabel 的大小
    _userNameLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+ 20, 20, nameRect.size.width, nameRect.size.height);
    _userNameLabel.backgroundColor = [UIColor redColor];


    _userDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _userDetailLabel.font = [UIFont systemFontOfSize:12.0];
    _userDetailLabel.textColor = [UIColor grayColor];
    _userDetailLabel.text = _userDetail;
    _userDetailLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+ 10, CGRectGetMaxY(_userNameLabel.frame)+10, 200,15);
    
    _memberBtn.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame)+ 10, 22, 50, 15);
    for (int i = 0; i<3; i++) {
        if(_level == 0){
            [_memberBtn setBackgroundImage:[UIImage imageNamed:@"userinfo_membership_expired@3x.png"] forState:UIControlStateNormal];
        }
        else if(_level == i)
        {
            [_memberBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"userinfo_membership_level%d@3x.png",i]] forState:UIControlStateNormal];
        }
    }

    
    [self addSubview:_userNameLabel];
    [self addSubview:_userImageView];
    [self addSubview:_userDetailLabel];
    [self addSubview:_memberBtn];
    
}
- (void)setNeckCell;
{
    
    _wbNumLabel= [UILabel new];
    _attentionNumLabel= [UILabel new];
    _fansNumLabel= [UILabel new];
    
    NSArray *infoLabelArr = @[_wbNumLabel,_attentionNumLabel,_fansNumLabel];
    NSArray *textArr = @[@"微博",@"关注",@"粉丝"];
    for (int i = 0;i < 3 ; i++) {
        UIButton * btnTmp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnTmp.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width/3.0, 0, [UIScreen mainScreen].bounds.size.width/3.0, 40);//40 cell高
        [btnTmp setBackgroundImage:[UIImage imageNamed:@"btn_gray_backgroud.png"] forState:UIControlStateHighlighted];
        [self addSubview:btnTmp];
        
        btnTmp.contentEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 0);
        [btnTmp setTintColor:[UIColor lightGrayColor]];
        btnTmp.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [btnTmp setTitle:[textArr objectAtIndex:i] forState:UIControlStateNormal];
        
        UILabel *numLabel = [infoLabelArr objectAtIndex:i];
        numLabel.frame = CGRectMake(0, 7, [UIScreen mainScreen].bounds.size.width/3.0, 13);
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:12.0];
        numLabel.text = [_userInfoNumArr objectAtIndex:i];
        
        [btnTmp addSubview:numLabel];
    }
  
}

- (void)addBtnTarget:(id)target action:(SEL)action
{
    NSArray* subviews = [self subviews];
    for (UIView* view in subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton* btn = (UIButton*)view;
            
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end


