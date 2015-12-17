
#import "UserHeaderView.h"
#import "UIImageView+WebCache.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
@interface UserHeaderView  ()
{
    UIImageView *backgroundImgv;
    UIImageView *userImgV;
    UILabel *userNameLabel;
    UIImageView *genderImgV;
    UIButton *memberBtn;
    UILabel *label;
    UIButton *attentionBtn;
    UIButton *fansBtn;
    UIButton *descriptionBtn;
    
}
@end
@implementation UserHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self initSubview];
        
    }
    return self;
}

-(void)initSubview
{
    backgroundImgv = [[UIImageView alloc]init];
    [self addSubview:backgroundImgv];

    userImgV = [[UIImageView alloc]init];
    [self addSubview:userImgV];

    userNameLabel = [[UILabel alloc]init];
    [self addSubview:userNameLabel];

    genderImgV = [[UIImageView alloc]init];
    [self addSubview:genderImgV];

    memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:memberBtn];
    
    label = [[UILabel alloc]init];
    [self addSubview:label];
    
    attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:attentionBtn];

    fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:fansBtn];
    
    descriptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:descriptionBtn];
}
- (void)setUserData:(WBUser *)userData
{
    backgroundImgv.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (userData.cover_image_phone == nil) {
        backgroundImgv.image = [UIImage imageNamed:@"userBackground.jpg"];
    }
    else{
    NSURL *url  = [NSURL URLWithString:userData.cover_image_phone];
        [backgroundImgv sd_setImageWithURL:url];
    }

    userImgV.frame=CGRectMake(0, 0, 70, 70);
    userImgV.layer.cornerRadius= userImgV.frame.size.width/2+0.5;
    userImgV.layer.masksToBounds=YES;
    userImgV.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.4].CGColor;
    userImgV.layer.borderWidth = 2;
    userImgV.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-120);
//    NSData *picData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userData.profile_image_url]];
//    userImgV.image = [UIImage imageWithData:picData];
    NSURL *url  = [NSURL URLWithString:userData.profile_image_url];
    [userImgV sd_setImageWithURL:url];
    userNameLabel.text = userData.name;
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    CGRect nameRect = [userNameLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    userNameLabel.frame = CGRectMake(self.center.x - nameRect.size.width-5,CGRectGetMaxY(userImgV.frame)+10 , nameRect.size.width , nameRect.size.height);
  
    
    genderImgV.frame = CGRectMake(self.center.x +5, userNameLabel.frame.origin.y+1, 17, 17);
    genderImgV.image = [UIImage imageNamed:@"userinfo_gender_male@2x.png"];
    
    memberBtn.frame=CGRectMake(self.center.x +17+5+5, userNameLabel.frame.origin.y+1, 35, 17);
    [memberBtn setBackgroundImage:[UIImage imageNamed:@"common_icon_membership_expired_self@3x.png"] forState:UIControlStateNormal];
    
    label.frame = CGRectMake(0, 0, 2, 13);
    label.text = @"|";
    label.center = CGPointMake(self.center.x, CGRectGetMaxY(userImgV.frame)+20+26);
    label.textColor = [UIColor whiteColor];
    
    NSString *attentionText = [@"关注  " stringByAppendingString:userData.friends_count.description];
    attentionBtn.frame = CGRectMake(label.frame.origin.x-60,label.frame.origin.y, 55, 13);
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [attentionBtn setTitle:attentionText forState:UIControlStateNormal];
    
    NSString *fansText = [@"粉丝  " stringByAppendingString:userData.followers_count.description];
    fansBtn.frame = CGRectMake(label.frame.origin.x+5,label.frame.origin.y, 60, 13);
    fansBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [fansBtn setTitle:fansText forState:UIControlStateNormal];
    
    NSString *descriptionText;
    if (userData.descriptionText != nil) {
        descriptionText = userData.descriptionText;
    }
    else
    {
        descriptionText = @"编辑简介";
    }
    CGRect titleRect = [descriptionText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    if (titleRect.size.width > 330) {
        titleRect.size.width = 330;
    }
    descriptionBtn.frame = CGRectMake(0 ,0, titleRect.size.width, 13);
    descriptionBtn.center = CGPointMake(self.frame.size.width/2.0, CGRectGetMaxY(userImgV.frame)+30+38);
    descriptionBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [descriptionBtn setTitle:descriptionText forState:UIControlStateNormal];
    descriptionBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

@end
