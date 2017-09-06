

#import "ViewController.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "HomeTabViewController.h"
#import "Constant.h"
#import "Postman.h"
#import "SignUpView.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

- (IBAction)loginViewButtonAction:(UIButton *)sender;
- (IBAction)signUpViewAction:(UIButton *)sender;

@end

@implementation ViewController
{
    Postman* postman;
    SignUpView*signupXib;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate=self;
    [GIDSignIn sharedInstance].delegate =self;
    
    // TouchID authentication method calling
    [self touchIDAuthentication];
   }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _signInHighletedView.backgroundColor=[UIColor colorWithRed:0.15 green:0.50 blue:0.63 alpha:1.0];

    FLAnimatedImage *lightningImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"signupgif" ofType:@"gif"]]];
    self.imageView.animatedImage = lightningImage;
    _signUpView.hidden=YES;
    [super viewWillAppear:animated];
    // Hide navigation controller
    self.navigationController.navigationBarHidden = YES;
    
    // Internet connection checking custom method calling
    [self internetConnectionChecking];

}

// Login page button action
- (IBAction)loginViewButtonAction:(UIButton *)sender
{
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _signUpHighlitedView.hidden=YES;
    _signInHighletedView.hidden=NO;
    _signUpView.hidden=YES;
    _signInHighletedView.backgroundColor=[UIColor colorWithRed:0.15 green:0.50 blue:0.63 alpha:1.0];
}

// Sing up page button action
- (IBAction)signUpViewAction:(UIButton *)sender
{
    
    [_loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_signupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _signUpHighlitedView.hidden=NO;
    _signInHighletedView.hidden=YES;
    _signUpHighlitedView.backgroundColor=[UIColor colorWithRed:0.15 green:0.50 blue:0.63 alpha:1.0];
    _signUpView.hidden=NO;
    //[_signUpView alphaViewInitialize];
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
    }
    else
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
- (IBAction)facebookAction:(id)sender {
    
    
}

- (IBAction)googleAction:(id)sender {
  [[GIDSignIn sharedInstance] signIn];
    
}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}


//delegate method
-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    
    
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    
    NSLog(@"%@",fullName);
    NSLog(@"%@",email);
    NSLog(@"%@",userId);
    if (email!=nil) {
        // The user has  signed in properly
        HomeTabViewController*homesubject=[[HomeTabViewController alloc]init];
        homesubject=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeTabViewController"];
        [self.navigationController pushViewController:homesubject animated:YES];
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        // The user has  not  signed in properly
    }
    
    //    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
    //    {
    //        NSUInteger dimension = round(2);
    //        NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
    //       UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    ////        _googleimg.image=image;
    //   }
    //    _userLabel.text=email;
    //    _fullLabel.text=fullName;
    
}
-(void)sendSignUpMailApi{
    NSString*parameter;
   
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,sendSignUpMail];
    parameter=[NSString stringWithFormat:@"{\"user_mail\":\"%@\",\"user_flag\":\"%@\"}"];
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getsignUpMailResponse:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
}
-(void)getsignUpMailResponse:(NSDictionary*)parameterDict{
}
- (IBAction)SignInAction:(id)sender {
}
-(void)signUpData:(id)signUpData{

    SetupViewController * itemsViewController = [[SetupViewController alloc]init];
    [itemsViewController.navigationController pushViewController:signUpData animated:YES];
}

// TouchID authentication method
-(void)touchIDAuthentication
{
    // Login with Touch-ID
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Use Touch ID to login in PlayAblo app";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       
                                                       [self performSegueWithIdentifier:@"SetupVw" sender:nil];
                                                       
                                                   });
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Touch ID"
                                                                                            message:@"User cancelled"
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles:nil, nil];
                                        [alertView show];
                                        NSLog(@"Switch to fall back authentication - ie, display a keypad or password entry box");
                                    });
                                }
                            }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:authError.description
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        });
    }

}
@end
