

#import <UIKit/UIKit.h>

@interface ForgotPassword : UIView<UITextFieldDelegate>
-(void)alphaintialiseview;
@property (strong, nonatomic) IBOutlet UITextField *userIdTXt;
@property (strong, nonatomic) IBOutlet UIButton *sendAction;
@end
