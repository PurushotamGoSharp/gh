

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "SignUpView.h"
#import "SetupViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface ViewController : UIViewController<GIDSignInUIDelegate,sendsignUpData>

@property (strong, nonatomic) IBOutlet UIButton *facebookBtn;
@property (strong, nonatomic) IBOutlet UIButton *googleBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *signupBtn;
@property (strong, nonatomic) IBOutlet SignUpView *signUpView;

@property (strong, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *signUpHighlitedView;
@property (strong, nonatomic) IBOutlet UIView *signInHighletedView;


@end

