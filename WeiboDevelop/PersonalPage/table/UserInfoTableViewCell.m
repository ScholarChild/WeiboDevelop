#import "UserInfoTableViewCell.h"

#define lineSpace 10.0 //间距
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface UserInfoTableViewCell ()
{
    UIImageView *_typeIconView;
    UILabel *_nameLabel;
    UILabel *_detailLabel;

}
@end
@implementation UserInfoTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        _nameLabel = [[UILabel alloc]init];
        _typeIconView = [[UIImageView alloc]init];
        _detailLabel = [[UILabel alloc]init];
        
        
    }
    return self;
}

- (void)setBodyCell
{
    _typeIconView.frame = CGRectMake(5, 5, 30, 30);
    _typeIconView.image = [UIImage imageNamed:_iconName];
    _nameLabel.font = [UIFont systemFontOfSize:15.0];
    _nameLabel.text = _name;
    CGRect nameRect = [_nameLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,25) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_typeIconView.frame)+lineSpace, 10, nameRect.size.width, nameRect.size.height);
    
    _detailLabel.font = [UIFont systemFontOfSize:12.0];
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.text = _detail;
    CGRect detailRect = [_detailLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    _detailLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+lineSpace, 13, detailRect.size.width, detailRect.size.height);
    
    [self addSubview:_nameLabel];
    [self addSubview:_typeIconView];
    [self addSubview:_detailLabel];
    
}

- (void)setNeckCell
{
    //子类去重写
}
- (void)setHeadCell
{
    //子类去重写
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
