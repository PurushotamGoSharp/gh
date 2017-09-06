

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passcodeTextField;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *fltImageView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end
