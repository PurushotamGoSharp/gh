

#import "HomeLeaderboardViewController.h"
#import <WYPopoverController/WYPopoverController.h>
#import "NotificationViewController.h"
#import "SwicthChildViewController.h"
#import "GiftViewController.h"
@interface HomeLeaderboardViewController ()<WYPopoverControllerDelegate>

@end

@implementation HomeLeaderboardViewController
{
    
    
    UIImage *switchChildImage;
    UIImage *pushNotificationImage;
    UIImage *giftImage;
    WYPopoverController *wypopOverController;
    
    SwicthChildViewController *switchVC;
    NotificationViewController *notificationVC;
    GiftViewController *giftVC;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title =@"LeaderBoard";

}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self CustomRightButton];
    
   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CustomRightButton
{
    switchChildImage = [UIImage imageNamed:@"swith-icon"];
    UIButton *switchChildButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchChildButton setImage:switchChildImage forState:UIControlStateNormal];
    switchChildButton.frame = CGRectMake(10.0,0.0,30.0,28.0);
    switchChildButton.showsTouchWhenHighlighted = YES;
    [switchChildButton addTarget:self action:@selector(tappedSwitchChild:) forControlEvents:UIControlEventTouchUpInside];
    
    
    pushNotificationImage = [UIImage imageNamed:@"alarm (1)-1"];
    UIButton *pushNotificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushNotificationButton setImage:pushNotificationImage forState:UIControlStateNormal];
    pushNotificationButton.frame = CGRectMake(10.0,0.0,30.0,28.0);
    pushNotificationButton.showsTouchWhenHighlighted = YES;
    [pushNotificationButton addTarget:self action:@selector(tappedNotification:) forControlEvents:UIControlEventTouchUpInside];
    
    giftImage = [UIImage imageNamed:@"gift"];
    UIButton *giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [giftButton setImage:giftImage forState:UIControlStateNormal];
    giftButton.frame = CGRectMake(10.0,0.0,30.0,28.0);
    giftButton.showsTouchWhenHighlighted = YES;
    [giftButton addTarget:self action:@selector(tappedGift:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithCustomView:switchChildButton];
    UIBarButtonItem *rightButton3 = [[UIBarButtonItem alloc] initWithCustomView:pushNotificationButton];
    UIBarButtonItem *rightButton4 = [[UIBarButtonItem alloc] initWithCustomView:giftButton];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:rightButton2,rightButton3,rightButton4, nil];
    
}

-(void)tappedNotification:(UIButton*)sender
{
    UIView *btn = (UIButton *)sender;
    if (wypopOverController==nil)
    {
        notificationVC=[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationControllerID"];
        notificationVC.delegate = self;
        [self wypopOverNotification:sender];
        CGSize contentSize = CGSizeMake(240,180);
        notificationVC.preferredContentSize=contentSize;
        
        CGRect biggerBounds = CGRectInset(btn.bounds, -6, -6);
        
        
        [wypopOverController presentPopoverFromRect:biggerBounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionUp) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
    }
    else
    {
        [wypopOverController dismissPopoverAnimated:YES completion:^{
            wypopOverController.delegate = nil;
            wypopOverController = nil;
        }];
    }
    
}

-(void)tappedSwitchChild:(UIButton*)sender
{
    UIView *btn = (UIButton *)sender;
    if (wypopOverController==nil)
    {
        giftVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewControllerID"];
        giftVC.delegate = self;
        [self wypopOverGift:sender];
        CGSize contentSize = CGSizeMake(240,180);
        giftVC.preferredContentSize=contentSize;
        
        CGRect biggerBounds = CGRectInset(btn.bounds, -6, -6);
        
        
        [wypopOverController presentPopoverFromRect:biggerBounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionUp) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
    }else
    {
        [wypopOverController dismissPopoverAnimated:YES completion:^{
            wypopOverController.delegate = nil;
            wypopOverController = nil;
        }];
    }
   
}
-(void)tappedGift:(UIButton*)sender
{
    UIView *btn = (UIButton *)sender;
    if (wypopOverController==nil)
    {
        giftVC=[self.storyboard instantiateViewControllerWithIdentifier:@"GiftViewControllerID"];
        giftVC.delegate = self;
        [self wypopOverGift:sender];
        CGSize contentSize = CGSizeMake(240,180);
        giftVC.preferredContentSize=contentSize;
        
        CGRect biggerBounds = CGRectInset(btn.bounds, -6, -6);
        
        
        [wypopOverController presentPopoverFromRect:biggerBounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionUp) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
    }else
    {
        [wypopOverController dismissPopoverAnimated:YES completion:^{
            wypopOverController.delegate = nil;
            wypopOverController = nil;
        }];
    }
}






-(void)wypopOver:(UIView*)btn
{
    wypopOverController=[[WYPopoverController alloc] initWithContentViewController:switchVC];
    
    wypopOverController.delegate = self;
    wypopOverController.passthroughViews = @[btn];
    wypopOverController.theme=[WYPopoverTheme themeForIOS6];
    wypopOverController.theme.outerCornerRadius=0;
    wypopOverController.theme.outerStrokeColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.arrowHeight =0;
    wypopOverController.theme.arrowBase= 0;
    wypopOverController.theme.fillTopColor =[UIColor clearColor];
    wypopOverController.theme.overlayColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    wypopOverController.theme.borderWidth=0;
    wypopOverController.theme.tintColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowBlurRadius=0;
}



-(void)wypopOverNotification:(UIView*)btn
{
    wypopOverController=[[WYPopoverController alloc] initWithContentViewController:notificationVC];
    
    wypopOverController.delegate = self;
    wypopOverController.passthroughViews = @[btn];
    wypopOverController.theme=[WYPopoverTheme themeForIOS6];
    wypopOverController.theme.outerCornerRadius=0;
    wypopOverController.theme.outerStrokeColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.arrowHeight =0;
    wypopOverController.theme.arrowBase= 0;
    wypopOverController.theme.fillTopColor =[UIColor clearColor];
    wypopOverController.theme.overlayColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    wypopOverController.theme.borderWidth=0;
    wypopOverController.theme.tintColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowBlurRadius=0;
}

-(void)wypopOverGift:(UIView*)btn
{
    wypopOverController=[[WYPopoverController alloc] initWithContentViewController:giftVC];
    
    wypopOverController.delegate = self;
    wypopOverController.passthroughViews = @[btn];
    wypopOverController.theme=[WYPopoverTheme themeForIOS6];
    wypopOverController.theme.outerCornerRadius=0;
    wypopOverController.theme.outerStrokeColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.arrowHeight =0;
    wypopOverController.theme.arrowBase= 0;
    wypopOverController.theme.fillTopColor =[UIColor clearColor];
    wypopOverController.theme.overlayColor= [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    wypopOverController.theme.borderWidth=0;
    wypopOverController.theme.tintColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowColor=[UIColor clearColor];
    wypopOverController.theme.outerShadowBlurRadius=0;
}



- (void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController
{
    wypopOverController.delegate = nil;
    wypopOverController = nil;
}

- (void)settingsVCSelectedMenuAtIndex:(NSInteger)index
{
    [wypopOverController dismissPopoverAnimated:YES completion:^{
        wypopOverController.delegate = nil;
        wypopOverController = nil;
    }];
    if (index==0) {
        
    }else if (index==1){
        // [self performSegueWithIdentifier:@"HometolanguageSegua" sender:nil];
        
    }else if (index==2){
        //[self performSegueWithIdentifier:@"hometoBugReportSegua" sender:nil];
    }else if (index==3){
        
        //[self performSegueWithIdentifier:@"hometoSoundVibSegua" sender:nil];
        
    }
    
}


@end
