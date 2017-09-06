
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "Postman.h"
#import "Constant.h"
#import "SingupModelData.h"
#import "MBProgressHUD.h"
@interface SignUpViewController ()
{
        UIImage *myImage;
        
        // String variable declaration to hold the user textfield value
        NSString *userName;
        NSString *email;
        NSString *phoneNumber;
        NSString *passcode;
        NSString *confirmPasscode;
    
        // Postman object declration
        Postman *postman;
        SingupModelData *sModelData;
        NSMutableArray *signupTabArray;
        MBProgressHUD *hud;
}

// Signup user text field outlet
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *proceedButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *passcodeShowButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *confirmPasscodeShowButtonOutlet;


// Signup proceed button action
- (IBAction)proceedButtonAction:(UIButton *)sender;
- (IBAction)passcodeShowButtonAction:(UIButton *)sender;
- (IBAction)confirmPasscodeShowButtonAction:(UIButton *)sender;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Postman object memory allocation
    postman = [[Postman alloc]init];
    signupTabArray=[[NSMutableArray alloc]init];
    
}


// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // Setting navigation title
    self.navigationItem.title =@"Sign Up";
    
    // Hide navigationbar
    self.navigationController.navigationBarHidden = NO;
    
    // Hide navigation back button
    self.navigationItem.hidesBackButton = YES;
   
    // Setting proceed button corner
    self.proceedButtonOutlet.layer.cornerRadius = 5;
    
    // Calling custom button method
    [self customBackButton];
    
    
    // Calling custom placeholder color
    [self placeholderColor];
    
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
    myImage = [UIImage imageNamed:@"direction196"];
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

// Sign up Proceed button action
- (IBAction)proceedButtonAction:(UIButton *)sender
{
//    if ([self signUpTextFieldValidation] ==YES)
//    {
//        if ([self internetConnectionChecking]== YES)
//        {
//        // Signup API method calling
//            [self signupUserExistEmailAPI];
//            [self signupTextFieldEmpty];
//        }
//        
//    }
//    else
//    {
//      
//    }
   

    
    // Go in Set-Up view
    [self performSegueWithIdentifier:@"setUpView" sender:self];
    

//    if ([self internetConnectionChecking]== YES)
//    {
//     
//     if ([self signUpTextFieldValidation] ==YES)
//     {
//         if ([self signupUserExistEmailAPI]==YES)
//         {
//             
//             hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//             hud.mode = MBProgressHUDModeIndeterminate;
//             hud.color = [UIColor clearColor];
//             // Transparent background color
//             hud.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.8];
//
//         }
//       
//    }
//        
//    }
//    else
//    {
//      
//    }
//    
   
}


// Custom placeholder color
-(void)placeholderColor
{
    UIColor *colorName = [UIColor whiteColor];
    _nameTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Enter your name"
     attributes:@{NSForegroundColorAttributeName:colorName}];
    
    
    UIColor *colorEmail = [UIColor whiteColor];
    _emailTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Enter your email"
     attributes:@{NSForegroundColorAttributeName:colorEmail}];
    
    UIColor *colorPhone = [UIColor whiteColor];
    _phoneTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Enter your phone no"
     attributes:@{NSForegroundColorAttributeName:colorPhone}];
    
    UIColor *colorPasword = [UIColor whiteColor];
    _passwordTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Enter 5-digit passcode"
     attributes:@{NSForegroundColorAttributeName:colorPasword}];
    
    UIColor *colorConfirmPassword = [UIColor whiteColor];
    _confirmPasswordTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Cofirm 5-digit passcode"
     attributes:@{NSForegroundColorAttributeName:colorConfirmPassword}];
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
    userName = _nameTextField.text;
    email = _emailTextField.text;
    phoneNumber = _phoneTextField.text;
    passcode = _passwordTextField.text;
    confirmPasscode = _confirmPasswordTextField.text;
    
    // Signup model data object and storing data in array
    sModelData= [[SingupModelData alloc]init];
    sModelData.username = userName;
    sModelData.EmailId = email;
    sModelData.passcode = passcode;
    sModelData.mobileno = phoneNumber;
    sModelData.userLoginType = @"Non social";
    [signupTabArray addObject:sModelData];
    
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
        [self presentViewController:alertController animated:YES completion:nil];
        
        
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
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// Hide keypad method
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

// Clear signup text field after going in next view
-(void)signupTextFieldEmpty
{
    self.nameTextField.text = @"";
    self.emailTextField.text = @"";
    self.phoneTextField.text = @"";
    self.passwordTextField.text = @"";
    self.confirmPasswordTextField.text = @"";
}


// Passcode show button action
- (IBAction)passcodeShowButtonAction:(UIButton *)sender
{
    if (self.passwordTextField.secureTextEntry == YES)
    {
      self.passwordTextField.secureTextEntry = NO;
    }
    else
    {
    self.passwordTextField.secureTextEntry = YES;
    }
   
}

// Confirm passcode show button action
- (IBAction)confirmPasscodeShowButtonAction:(UIButton *)sender
{
    if (self.confirmPasswordTextField.secureTextEntry == YES)
    {
        self.confirmPasswordTextField.secureTextEntry = NO;
    }
    else
    {
        self.confirmPasswordTextField.secureTextEntry = YES;
    }
    
   
}


// Signup API calling method
-(BOOL)signupUserExistEmailAPI
{
     BOOL isSuccess = YES;
     NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,sExistUserEmail];
     NSString *parameter=[NSString stringWithFormat:@"{\"user_email\":\"%@\",}",email];
    
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
    
   // if ([responseDict[@"success"] intValue]==1)
   // {
        [self showAlerViewSuccess:responseDict[@"message"]];
        [self signupTextFieldEmpty];
        // Hide hud here
        [hud hide:YES];
    
   // }
//    else
//    {
//        [self showAlerViewFailure:responseDict[@"message"]];
//    }
    

}

// Signup success custom alert meassage method
-(void)showAlerViewSuccess:(NSString*)msg
{
    
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"Alert!" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *success=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action)
    {
        
        // Go in Set-Up view
       // [self performSegueWithIdentifier:@"setUpView" sender:self];
     
        
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [success setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];

    [alertView addAction:success];
    [self presentViewController:alertView animated:YES completion:nil];
}

// Signup success custom alert meassage method
-(void)showAlerViewFailure:(NSString*)msg
{
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"Alert!" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *success=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
       
        
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [success setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    
    [alertView addAction:success];
    [self presentViewController:alertView animated:YES completion:nil];
}



@end
