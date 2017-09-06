
#import <UIKit/UIKit.h>
@protocol SwitchChildDelegateVCDelegate <NSObject>

- (void)settingsVCSelectedMenuAtIndex:(NSInteger)index;

@end

@interface SwicthChildViewController : UIViewController
@property (weak, nonatomic) id<SwitchChildDelegateVCDelegate> delegate;

@end
