

#import "RateUs.h"
#import "AppDelegate.h"
@implementation RateUs

{
    UIView*view;
    UIControl *alphaview;
    AppDelegate*appdelegate;
    NSMutableArray*tableData;
    NSIndexPath *selectedIndex;
}
-(id)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    view=[[NSBundle mainBundle]loadNibNamed:@"RateUsXIB" owner:self options:nil].lastObject;
    view.frame=self.bounds;
    [self addSubview:view];
    return self;
}

-(void)alphaintialiseview
{
    if (alphaview==nil)
    {
        alphaview=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        alphaview.backgroundColor=
        [UIColor colorWithRed:0.152 green:0.188 blue:0.196 alpha:1.0];
        [alphaview addSubview:view];
    }
    view.center=alphaview.center;
    view.layer.cornerRadius=6;
   
    appdelegate=[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:alphaview];
    view.backgroundColor=[UIColor whiteColor];
      
}

-(void)done
{
    [alphaview removeFromSuperview];
}
- (IBAction)laterButtonACtion:(id)sender
{
    [alphaview removeFromSuperview];

}

@end
