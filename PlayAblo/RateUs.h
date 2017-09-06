

#import <UIKit/UIKit.h>
@protocol alphaViewDelegate <NSObject>
@end

@interface RateUs : UIView
-(void)alphaintialiseview;
@property(nonatomic)id<alphaViewDelegate>delegate;
@end
