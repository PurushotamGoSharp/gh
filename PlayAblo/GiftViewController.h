

#import <UIKit/UIKit.h>

@protocol SettingsVCDelegate <NSObject>

- (void)settingsVCSelectedMenuAtIndex:(NSInteger)index;

@end

@interface GiftViewController : UIViewController
@property (weak, nonatomic) id<SettingsVCDelegate> delegate;

@end
