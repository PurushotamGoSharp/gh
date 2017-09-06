

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "Postman.h"
#import "Constant.h"
#import "ForgotPassword.h"

@interface LoginViewController ()
{
    UIImage *myImage;
    Postman* postman;
    ForgotPassword* forgotXib;
}
@property(nonatomic,strong)NSString *buildCommit;
@property(nonatomic,strong)NSString *buildVersion;
@end

@implementation LoginViewController


- (void)viewDidLoad
{
    
        [super viewDidLoad];
       postman=[[Postman alloc]init];
       _userTextField.delegate=self;
       _passcodeTextField.delegate=self;

    
}
// Unhide navigation and Set navigation title name
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    FLAnimatedImage *lightningImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"signupgif" ofType:@"gif"]]];
    _fltImageView.animatedImage = lightningImage;
    self.navigationController.navigationBarHidden = YES;
    //self.navigationItem.hidesBackButton = NO;
    
    // Calling custom back button method
    [self customBackButton];
    
    // Internet connection checking custom method calling
    [self internetConnectionChecking];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// Custom back button
-(void)customBackButton
{
    myImage = [UIImage imageNamed:@"back_Arrow"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    
    
    myButton.frame = CGRectMake(10.0, 0.0,24, 24);
    [myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

// Custom back button action
-(void)tapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


// Internet connection checking custom method
-(void)internetConnectionChecking
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"Cannot find internet...boo!");
        // Internet connection custom alert meassage method calling
        [self networkReachabilityAlertMessage];
    } else
    {
        NSLog(@"Found internet....yea!");
    }
    
}
// Internet connection custom alert meassage method
-(void)networkReachabilityAlertMessage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error!"  message:@"No Internet connection" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    
    [alertController addAction:ok];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)userLoginApi{
    NSUserDefaults *defaultValues=[NSUserDefaults standardUserDefaults];
    NSString *deviceToken=[defaultValues valueForKey:@"deviceToken"];
     NSString*parameter;
    _buildCommit     = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    _buildVersion   =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString*version= [NSString stringWithFormat:@"%@",_buildVersion];
    NSString* consumerKey = @"8633e742-e04f-4e41-9862-84102154d1ea";
    NSString* consumerSecret = @"f5faa44f-dbc1-49c3-b746-2e55fe11c340";
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,userLogin];
    parameter=[NSString stringWithFormat:@"{\"app_version\":\"%@\",\"EmailId\":\"%@\",\"Password\":\"%@\",\"ConsumerKey\":\"%@\",\"ConsumerSecret\":\"%@\",\"device_type\":5,\"device_token\":\"%@\"}",version,_userTextField.text,_passcodeTextField.text,consumerKey,consumerSecret,deviceToken];
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getuserLoginResponse:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
}
-(void)getuserLoginResponse:(NSDictionary*)parameterDict{
    NSLog(@"%@",parameterDict);
    
    
    
    
    
    
}
- (IBAction)forgorpasscodeAction:(id)sender {
    
    if (forgotXib==nil)
    {
        forgotXib=[[ForgotPassword alloc]initWithFrame:CGRectMake(10, 10, 270, 150)];
       }
    [forgotXib alphaintialiseview];
}
- (IBAction)loginAction:(id)sender {
    
    [self userLoginApi];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userTextField resignFirstResponder];
    [_passcodeTextField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)backBtnAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
