 

#import "MyButton.h"
#define Width self.frame.size.width
#define Height self.frame.size.height
#define ViewHeight 2.5
@interface MyButton()
{
    BOOL show;
}
@end
@implementation MyButton

-(void)myViewImg:(UIImage *)img endText:(NSString *)string{
    
    UIImageView* view=[[UIImageView alloc]initWithFrame:CGRectMake(ViewHeight, ViewHeight, Width-ViewHeight*2, Height-ViewHeight*2)];
    view.image=img;
    self.imgView=view;
    [self addSubview:view];
    self.label=[[UILabel alloc]init];
    self.label.text=string;
    show=NO;
    [self labelFrame];
    
    self.label.textAlignment= NSTextAlignmentCenter;
    
    [self addSubview:self.label];
    
}
-(void)labelFrame{
    CGFloat labelY=CGRectGetMaxY(self.imgView.frame)+5;
    self.label.font=[UIFont systemFontOfSize:12.0];
    self.label.frame=CGRectMake(ViewHeight, labelY, 70, 15);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.imgView.frame=CGRectMake(0,0, Width,Height);
    [self labelFrame];
    self.label.font=[UIFont systemFontOfSize:15.0];
    show=NO;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [super touchesMoved:touches withEvent:event];
    UITouch* touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    
    if (point.y>Height||point.y<0||point.x>Width||point.x<0) {
        self.imgView.frame=CGRectMake(ViewHeight, ViewHeight, Width-ViewHeight*2, Height-ViewHeight*2);
        [self labelFrame];
        show=YES;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!show) {
        [super touchesEnded:touches withEvent:event];
    }
    
    self.imgView.frame=CGRectMake(ViewHeight, ViewHeight, Width-ViewHeight*2, Height-ViewHeight*2);
    [self labelFrame];
}

@end
