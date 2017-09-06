

#import "HomeReportViewController.h"
#import <WYPopoverController/WYPopoverController.h>
#import "SwicthChildViewController.h"
#import "GiftViewController.h"
#import "NotificationViewController.h"
@interface HomeReportViewController ()<WYPopoverControllerDelegate>

@end

@implementation HomeReportViewController
{
    
    
    UIImage *switchChildImage;
    UIImage *pushNotificationImage;
    UIImage *giftImage;

    WYPopoverController *wypopOverController;
    
    NotificationViewController *notificationVC;
    SwicthChildViewController *switchVC;
    GiftViewController *giftVC;

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title =@"Reports";
    [self CustomRightButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)CustomRightButton
{
    switchChildImage = [UIImage imageNamed:@"swith-icon"];
    UIButton *switchChildButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchChildButton setImage:switchChildImage forState:UIControlStateNormal];
    switchChildButton.frame = CGRectMake(10.0,0.0,30.0,28.0);
    switchChildButton.showsTouchWhenHighlighted = YES;
    [switchChildButton addTarget:self action:@selector(tappedSwitchChild:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithCustomView:switchChildButton];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:rightButton2,nil];
}


-(void)tappedSwitchChild:(UIButton*)sender
{
    UIView *btn = (UIButton *)sender;
    if (wypopOverController==nil)
    {
        switchVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewControllerID"];
        switchVC.delegate = self;
        [self wypopOver:sender];
        CGSize contentSize = CGSizeMake(240,180);
        switchVC.preferredContentSize=contentSize;
        
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
