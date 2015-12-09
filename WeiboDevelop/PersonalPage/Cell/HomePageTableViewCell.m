#import "HomePageTableViewCell.h"
#import "UIImageView+WebCache.h"
#define lineSpace 10.0 //间距
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface HomePageTableViewCell()
{
    UIImageView *_userImageView;
    UILabel *_userNameLabel;
    UILabel *_userDetailLabel;
    
    NSArray *btnArr;
    UIButton *_wbNumBtn;
    UIButton *_attentionNumBtn;
    UIButton *_fansNumBtn;
    
    NSArray *infoLabelArr;
    UILabel *_wbNumLabel;
    UILabel *_attentionNumLabel;
    UILabel *_fansNumLabel;
}
@end
@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return self;
}
- (void)initHeadSubviews
{
    _userImageView = [UIImageView new];
    _userNameLabel = [UILabel new];
    _userDetailLabel= [UILabel new];
    
    
    
    _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:_userNameLabel];
    [self addSubview:_userImageView];
    [self addSubview:_userDetailLabel];
    [self addSubview:_memberBtn];
    
}
- (void)initNeckSubviews;
{
    _wbNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _attentionNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _fansNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    _wbNumLabel= [UILabel new];
    _attentionNumLabel= [UILabel new];
    _fansNumLabel= [UILabel new];
    
    infoLabelArr = @[_wbNumLabel,_attentionNumLabel,_fansNumLabel];
    btnArr = @[_wbNumBtn,_attentionNumBtn,_fansNumBtn];

}
-(void)setHeadUserData:(WBUser *)headUserData
{
    if (headUserData.descriptionText!=nil) {
        _userDetailLabel.text = [@"简介: "  stringByAppendingString: headUserData.descriptionText ];
    }
    
//    NSData *picData = [NSData dataWithContentsOfURL:[NSURL URLWithString:headUserData.profile_image_url]];
//    _userImageView.image = [UIImage imageWithData:picData];
    _userImageView.frame = CGRectMake(10, 10, 60, 60);
    NSURL *url  = [NSURL URLWithString:headUserData.profile_image_url];
    [_userImageView sd_setImageWithURL:url];
    _userImageView.layer.cornerRadius=_userImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds=YES;
    
    _userNameLabel.text = headUserData.name;
    _userNameLabel.backgroundColor = [UIColor redColor];
    CGRect nameRect = [_userNameLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    _userNameLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+ 20, 20, nameRect.size.width, nameRect.size.height);
    
   
    
    UIImage *image =[UIImage imageNamed:@"common_icon_membership_expired_self@3x.png"] ;
    [_memberBtn setBackgroundImage:image forState:UIControlStateNormal];
    _memberBtn.frame = CGRectMake(CGRectGetMaxX(_userNameLabel.frame)+ 10, 22, 50, 15);
    
    _userDetailLabel.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+ 10, CGRectGetMaxY(_userNameLabel.frame)+10, 250,15);
    _userDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _userDetailLabel.font = [UIFont systemFontOfSize:12.0];
    _userDetailLabel.textColor = [UIColor grayColor];
}

- (void)setNeckUserData:(WBUser *)neckUserData
{
    
    NSArray *textArr = @[@"微博",@"关注",@"粉丝"];
    for (int i = 0;i < 3 ; i++) {
        UIButton * btnTmp = [btnArr objectAtIndex:i];
        btnTmp.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width/3.0, 0, [UIScreen mainScreen].bounds.size.width/3.0, 40);
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
        [btnTmp addSubview:numLabel];
    }
    _wbNumLabel.text = neckUserData.statuses_count.debugDescription;
    _attentionNumLabel.text = neckUserData.friends_count.description;
    _fansNumLabel.text = neckUserData.followers_count.description;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end


