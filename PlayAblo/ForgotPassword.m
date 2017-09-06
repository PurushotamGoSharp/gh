

#import "ForgotPassword.h"
#import "AppDelegate.h"
#import "Postman.h"
#import "Constant.h"

@implementation ForgotPassword
{
    UIControl*alphaview;
    UIView*view;
    AppDelegate*appdelegate;
    Postman*postman;
}
-(id)initWithFrame:(CGRect)frame
{
    
    self=[super initWithFrame:frame];
    view=[[NSBundle mainBundle]loadNibNamed:@"ForgotPassword" owner:self options:nil].lastObject;
    view.frame=self.bounds;
    [self addSubview:view];
    
    _userIdTXt.delegate=self;
    
    return self;
}
-(void)alphaintialiseview
{
    if (alphaview==nil)
    {
        alphaview=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        alphaview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.8];
        [alphaview addSubview:view];
        
    }
    view.center=alphaview.center;
    view.layer.cornerRadius=6;
   
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [self->view addGestureRecognizer:singleTap];
    
    //    view.layer.borderColor = ([UIColor colorWithRed:255 green:.32 blue:.08 alpha:1]).CGColor;
    //    view.layer.borderWidth = 4.0f;
    
    
    appdelegate=[UIApplication sharedApplication].delegate;
    [appdelegate.window addSubview:alphaview];
    view.backgroundColor=[UIColor whiteColor];
    [alphaview addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

-(void)hide{
    [alphaview removeFromSuperview];
}
-(void)forgotPasscodeApi{
    NSString*parameter;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,forgotPasscode];
    parameter=[NSString stringWithFormat:@"{\"user_email\":\"%@\"}",_userIdTXt.text];
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getforgotResponse:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
}
-(void)getforgotResponse:(NSDictionary*)parameterDict{
    NSLog(@"%@",parameterDict);
    
    
}
- (IBAction)sendActionMethod:(id)sender {
    [self forgotPasscodeApi];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userIdTXt resignFirstResponder];
        return YES;
}
@end
