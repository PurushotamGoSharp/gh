

#import <UIKit/UIKit.h>
#import "SingupModelData.h"
#import "SetupViewController.h"

@protocol sendsignUpData<NSObject>
-(void)signUpData:(id)signUpData;
@end
@interface SignUpView : UIView<UITextFieldDelegate>

-(void)alphaViewInitialize;
@property(weak,nonatomic)id<sendsignUpData>delegateForSignUp;
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

@property (strong, nonatomic) IBOutlet UITextField *mobileTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordtxt;

@end
