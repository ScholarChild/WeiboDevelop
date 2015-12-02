#import "FindPageNewsVIew.h"
#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height

@implementation FindPageNewsVIew


-(void)drawRect:(CGRect)rect
{

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);

  

    //像素为奇数
//    小数点为0.5
    // 像素为偶
    //如果舍弃小数点
    CGFloat height = (int)(viewHeight/2.0)+0.5;
    CGFloat width = (int)(viewWidth/2.0)+0.5;
    //横线
    CGContextMoveToPoint(context, 18, height);
    CGContextAddLineToPoint(context, width-13, height);
    
    CGContextMoveToPoint(context, width+13, height);
    CGContextAddLineToPoint(context, viewWidth+0.5 - 18, height);
    
    //竖线
    CGContextMoveToPoint(context, width,10);
    CGContextAddLineToPoint(context, width, height-10);
    
    CGContextMoveToPoint(context, width, height+10);
    CGContextAddLineToPoint(context, width, viewHeight+0.5-10);
    
//    [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>];
    [FindPageNewsVIew colorWithRGB:0xF7F7F7 alpha:1];
    CGContextSetStrokeColorWithColor(context, [FindPageNewsVIew colorWithRGB:0xD4D4D4 alpha:1].CGColor);
    CGContextStrokePath(context);
    
}

+(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
@end
