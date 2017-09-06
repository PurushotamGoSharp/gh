//
//  SetUpGradeView.m
//  PlayAblo
//
//  Created by preeti kumari on 9/6/17.
//  Copyright © 2017 Go Sharp Technologies Pvt. Ltd. All rights reserved.
//

#import "SetUpGradeView.h"
#import "AppDelegate.h"
#import "Postman.h"

@implementation SetUpGradeView{
    UIControl*alphaview;
    AppDelegate*appdelegate;
    Postman*postman;
    UIView*view;
    

}

-(id)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    view=[[NSBundle mainBundle]loadNibNamed:@"SetUpGradeView" owner:self options:nil].lastObject;
    view.frame=self.bounds;
    [self addSubview:view];
    
       
    return self;
}
-(void)alphaintialiseview
{
    if (alphaview==nil)
    {
        alphaview=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        alphaview.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [alphaview addSubview:view];
        
    }
//    view.center=alphaview.center;
//    view.layer.cornerRadius=6;
    
    
    
    //    view.layer.borderColor = ([UIColor colorWithRed:255 green:.32 blue:.08 alpha:1]).CGColor;
    //    view.layer.borderWidth = 4.0f;
    
    
    appdelegate=[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:alphaview];
       [alphaview addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

-(void)hide{
    [alphaview removeFromSuperview];
}
@end
