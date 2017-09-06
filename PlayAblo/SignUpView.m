

#import "SignUpView.h"
#import "AppDelegate.h"
#import "Postman.h"
#import "SetupViewController.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@implementation SignUpView{
    AppDelegate*appdelegate;
    Postman*postman;
    UIControl*alphaView;
     UIView *view;
    SetupViewController *setUp;
    Constant*constant;
    NSString *userName,*email,*phoneNumber,*passcode,*confirmPasscode;
    MBProgressHUD*hud;

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
   
      if ((self = [super initWithCoder:aDecoder])){
          
    UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"SignUpView" owner:self options:nil] objectAtIndex:0];
        [self addSubview: subView];
          
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = NSDictionaryOfVariableBindings(subView);
        
NSArray *constrains = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[subView]-(0)-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:views];
        [self addConstraints:constrains];
        
        constrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[subView]-(0)-|"
                                                             options:kNilOptions
                                                             metrics:nil
                                                               views:views];
        [self addConstraints:constrains];
        appdelegate=  [UIApplication sharedApplication].delegate;
        postman=[[Postman alloc]init];
       
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingle:)];
    [self->view addGestureRecognizer:singleTap];

    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    CGSize size = frame.size;
    size.width = frame.size.height;
    size.height = frame.size.width;
    _nameTxt.delegate=self;
    _mobileTxt.delegate=self;
    _emailTxt.delegate=self;
    _passwordTxt.delegate=self;
    _confirmPasswordtxt.delegate=self;
    
    return  self;
}
+ (BOOL) isAfterIOS8 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}

-(void)alphaViewInitialize{
    
    if (alphaView == nil)
    {
        alphaView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alphaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        [alphaView addSubview:view];
    }
    
    

    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    
    [appDel.window addSubview:alphaView];
     [self layoutIfNeeded];
   

}
- (IBAction)signActiom:(id)sender
{
    [self signupUserExistEmailAPI];
    UIStoryboard * stroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SetupViewController * itemsViewController = [stroryBoard instantiateViewControllerWithIdentifier:@"SetupViewController"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    [[self window]setRootViewController:navController];
    
}
// Signup API calling method
-(BOOL)signupUserExistEmailAPI
{
    BOOL isSuccess = YES;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,sExistUserEmail];
    NSString *parameter=[NSString stringWithFormat:@"{\"user_email\":\"%@\"}",_emailTxt.text];
    
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         
         [self getResponseData:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
    
    return isSuccess;
    
}
// Getting response from server
-(void)getResponseData:(NSDictionary *)parameterDict
{
    NSLog(@"%@",parameterDict);
    NSDictionary *responseDict = parameterDict[@"data"];
    //[self showToastMessage:responseDict[@"message"]];
    [self signupTextFieldEmpty];
    
//    [hud hide:YES];
    
    
}

//-(void)showToastMessage:(NSString*)msg
//{
//    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:alphaView animated:YES];
//    hubHUD.mode=MBProgressHUDModeText;
//    if (msg.length>0)
//    {
//        hubHUD.detailsLabelText=msg;
//    }
//    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
//    hubHUD.margin=20.f;
//    hubHUD.yOffset=150.f;
//    hubHUD.removeFromSuperViewOnHide = YES;
//    [hubHUD hide:YES afterDelay:2];
//    
//}
-(void)signupTextFieldEmpty
{
    _nameTxt.text = @"";
    _emailTxt.text = @"";
    _mobileTxt.text = @"";
    _passwordTxt.text = @"";
    _confirmPasswordtxt.text = @"";
}

// Email validation
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

// User-name validation
-(BOOL)NSStringIsValidUserName:(NSString *)checkUserName
{
    NSString *useNames = @"[a-zA-Z]*$";
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", useNames];
    BOOL isValid = [predicate evaluateWithObject:checkUserName];
    return isValid;
}

// Phone no validation
-(BOOL)NSStringIsValidPhoneNo:(NSString *)checkUserName
{
    NSString *phoneNumbers = @"[0-9]*$";
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumbers];
    BOOL isValid = [predicate evaluateWithObject:checkUserName];
    return isValid;
}
// Password valiadtion
-(BOOL)NSStringIsValidPassword:(NSString *)checkPassword
{
    
    NSString *passwords = @"^\w*(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])(?=\w*[@#$%^&+=])\w*$";
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwords];
    BOOL isValid = [predicate evaluateWithObject:checkPassword];
    return isValid;
}

// Signup text field validation
-(BOOL)signUpTextFieldValidation
{
    userName = _nameTxt.text;
    email = _emailTxt.text;
    phoneNumber = _mobileTxt.text;
    passcode = _passwordTxt.text;
    confirmPasscode = _confirmPasswordtxt.text;
    
//    // Signup model data object and storing data in array
//    sModelData= [[SingupModelData alloc]init];
//    sModelData.username = userName;
//    sModelData.EmailId = email;
//    sModelData.passcode = passcode;
//    sModelData.mobileno = phoneNumber;
//    sModelData.userLoginType = @"Non social";
//    [signupTabArray addObject:sModelData];
//    
    BOOL goodToGo=YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    if (userName.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"Name is required\n"];
    }
    else if (![self NSStringIsValidUserName:userName])
    {
        goodToGo=NO;
        [mutableString appendString:@"Invalid User name\n"];
        
    }
    
    
    if (email.length==0) {
        
        goodToGo=NO;
        [mutableString appendString:@"Email is required\n"];
        
    }
    else if (![self NSStringIsValidEmail:email])
    {
        goodToGo=NO;
        [mutableString appendString:@"Invalid EmailID\n"];
    }
    
    if (phoneNumber.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"Phone no is required\n"];
    }
    
    if (passcode.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"Passcode is required\n"];
    }
    else if (confirmPasscode.length<=4)
    {
        goodToGo=NO;
        [mutableString appendString:@"Passcode should be min 5 character\n"];
    }
    else if (passcode.length<=4)
    {
        goodToGo=NO;
        [mutableString appendString:@"Passcode should be min 5 character\n"];
    }
    if (passcode != confirmPasscode)
    {
        goodToGo=NO;
        [mutableString appendString:@"Passcode does not match\n"];
        
    }
    
    if (!goodToGo)
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Alert !!"
                                              message:mutableString
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        [okAction setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
        [alertController addAction:okAction];
        //[self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    return goodToGo;
}


// Internet connection checking custom method
-(BOOL)internetConnectionChecking
{
    BOOL isNetwork =YES;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"Cannot find internet...boo!");
        // Internet connection custom alert meassage method calling
        [self networkReachabilityAlertMessage];
        isNetwork = NO;
    } else
    {
        NSLog(@"Found internet....yea!");
        isNetwork = YES;
    }
    return isNetwork;
}

// Internet connection custom alert meassage method
-(void)networkReachabilityAlertMessage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error!"  message:@"No Internet connection" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             
                         }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    
    [alertController addAction:ok];
    [alertController.view setTintColor:[UIColor yellowColor]];
    //[self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)sendSignUpMailApi{
    NSString*parameter;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,sendSignUpMail];
    parameter=[NSString stringWithFormat:@"{\"user_mail\":\"%@\",\"user_flag\":\"mail\"}",_nameTxt.text];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTxt resignFirstResponder];
    [_emailTxt resignFirstResponder];
    [_mobileTxt resignFirstResponder];
    [_confirmPasswordtxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];
        return YES;
}

// Hide keypad
-(void)handleSingle:(UITapGestureRecognizer *)sender
{
    [_nameTxt resignFirstResponder];
    [_emailTxt resignFirstResponder];
    [_mobileTxt resignFirstResponder];
    [_confirmPasswordtxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];
    
}
// Hide keypad
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [_nameTxt resignFirstResponder];
        [_emailTxt resignFirstResponder];
        [_mobileTxt resignFirstResponder];
        [_confirmPasswordtxt resignFirstResponder];
        [_passwordTxt resignFirstResponder];
        
        
    }
}

@end
