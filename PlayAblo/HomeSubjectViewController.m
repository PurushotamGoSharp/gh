

#import "HomeSubjectViewController.h"
#import <WYPopoverController.h>
#import "NotificationViewController.h"
#import "iCarousel.h"
#import "SwicthChildViewController.h"
#import "GiftViewController.h"
#import "SubjectViewController.h"
#import "CarouselModelData.h"
#import "Postman.h"
@interface HomeSubjectViewController ()<WYPopoverControllerDelegate,NotificationVCDelegate,iCarouselDataSource,SettingsVCDelegate>
@property (nonatomic, strong) NSMutableArray *items;

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideMenuOutlet;
@property (weak, nonatomic) IBOutlet UILabel *playingChildNameOutlet;
@property (weak, nonatomic) IBOutlet UIView *childPlayingViewOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *playingChildImageOutlet;

@property (nonatomic, strong) NSMutableArray *subTitleArray;
@end

@implementation HomeSubjectViewController
{
   
    UIImage *switchChildImage;
    UIImage *pushNotificationImage;
    UIImage *giftImage;
    BOOL buttonIsSelected;
    UIColor * selectedColour;
    UIColor * defaultColour;
    BOOL *isHighlighted;
    
    WYPopoverController *wypopOverController;
    SwicthChildViewController *switchVC;
    NotificationViewController *notificationVC;
    GiftViewController *giftVC;
    
    NSMutableArray *subImgArrayData;
    CarouselModelData *cModelData;
    NSMutableArray *carouselDataTableArray;
    NSIndexPath *indexpath;
    Postman *postman;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    
    
    
    //subImgArrayData = @[@"1.jpg",@"2.jpg",@"3.jpg",];
    subImgArrayData = @[@"Group 1156",@"Group 1155",@"Group 1156"];
    
    //your item views move off-screen
    self.subTitleArray = [[NSMutableArray alloc]init];
    _subTitleArray = [NSMutableArray arrayWithObjects:@"ENGLISH", @"MATHEMATICS",@"ENGLISH",nil];
    for (int i = 0; i <3; i++)
    {
        [_subTitleArray addObject:@(subImgArrayData.count)];
    }
    
   
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title =@"Subject";
    _carousel.type = iCarouselTypeCylinder;
    
    
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title =@"Subject";
    [self CustomRightButton];
    self.carousel = nil;
    
    self.childPlayingViewOutlet.backgroundColor= [UIColor colorWithRed:0.43 green:.27 blue:.70 alpha:1.0];
    
    self.playingChildNameOutlet.alpha = 1;
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        self.playingChildNameOutlet.alpha = 0;
    } completion:nil];
    
    // Making circle image
    _playingChildImageOutlet.layer.cornerRadius = _playingChildImageOutlet.frame.size.height /2;
    _playingChildImageOutlet.layer.masksToBounds = YES;
    _playingChildImageOutlet.layer.borderWidth = 0;
    _playingChildImageOutlet.clipsToBounds = true;
    
}


- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// Custom right button method
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
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [subImgArrayData count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    
    UILabel *label = nil;
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        UIImageView *itemView ;
        itemView = [[UIImageView alloc]init];
        itemView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,450,450)];
        itemView.image = [UIImage imageNamed:[subImgArrayData objectAtIndex:index]];
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 450, 450)];
        
        cModelData.subImage = carouselDataTableArray;
        ((UIImageView *)view).image = [UIImage imageNamed:[subImgArrayData objectAtIndex:index]];
        //[UIImage imageNamed:@"page.png"];
        
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:15];
        label.tintColor = [UIColor whiteColor];
        label.textColor = [UIColor whiteColor];
        label.tag = 1;
        label.hidden= YES;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    label.text =[NSString stringWithFormat:@"%@",_subTitleArray[index]];
    return view;
}

// Carousel didSelect Item and then go to next viewcontroller
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (index == carousel.currentItemIndex)
    {
        
        SubjectViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"subjectView"];
        cModelData=carouselDataTableArray[indexpath.row];
        dvc.subjectName=[_subTitleArray objectAtIndex:index];
        [self.navigationController pushViewController:dvc animated:YES];
        
    }
    
}

// Carousel local Data
-(void)carouselData
{
    cModelData = [[CarouselModelData alloc]init];
    cModelData.subName = @"Mathematics";
    cModelData.subImage = [UIImage imageNamed:@"1-3"];
    [carouselDataTableArray addObject:cModelData];
    
    cModelData = [[CarouselModelData alloc]init];
    cModelData.subName = @"English";
    cModelData.subImage = [UIImage imageNamed:@"1-3"];
    [carouselDataTableArray addObject:cModelData];
    
    
    cModelData = [[CarouselModelData alloc]init];
    cModelData.subName = @"Hindi";
    cModelData.subImage = [UIImage imageNamed:@"1-3"];
    [carouselDataTableArray addObject:cModelData];
}

// Get subject API method
-(void)getSubjectAPI
{
   NSString *childID = @"child";
   NSUInteger gradeID = 2;
   NSString *requestName= @"Purushottam";
   NSString *sessionID= @"abcde";
   NSLog(@"%@%lu%@%@",childID,(unsigned long)gradeID,requestName,sessionID);
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,sExistUserEmail];
    NSString *parameter=[NSString stringWithFormat:@"{\"ChildId\":\"%@\",\"GradeId\":\"%lu\",\"request_name\": \"%@\",\"session_id\":\"%@\"}",childID,(unsigned long)gradeID,requestName,sessionID];
    
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         
         [self getResponseData:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
}

// Get subject name response from server
-(void)getResponseData:(NSDictionary*)parameterDict
{
    NSLog(@"Subject response data:%@",parameterDict);
}

@end
