

#import <UIKit/UIKit.h>
@protocol NotificationVCDelegate <NSObject>

- (void)NotificationVCSelectedMenuAtIndex:(NSInteger)index;

@end

@interface NotificationViewController : UIViewController
@property (weak, nonatomic) id<NotificationVCDelegate> delegate;
@end
