

#import "HomeTabViewController.h"

@interface HomeTabViewController ()

@end

@implementation HomeTabViewController

{
    UIImage *myImage;
    UIImage *myImage1;
    UIImage *myImage2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    self.navigationController.navigationBarHidden = YES;
    [self CustomRightButton];
    
    // Custom height of tabbar controller method calling
    [self viewWillLayoutSubviews];
    
}

-(void)CustomRightButton
{
    
    myImage = [UIImage imageNamed:@"icons8-Home Filled"];
    UIButton *myButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton1 setImage:myImage forState:UIControlStateNormal];
    myButton1.frame = CGRectMake(10.0, 0.0,24, 24);
    [myButton1 addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithCustomView:myButton1];
    self.navigationItem.rightBarButtonItem = leftButton1;
    
    
    myImage1 = [UIImage imageNamed:@"icons8-Home Filled"];
    UIButton *myButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton2 setImage:myImage1 forState:UIControlStateNormal];
    myButton2.frame = CGRectMake(10.0,0.0,80.0,24.0);
    [myButton2 addTarget:self action:@selector(tappedShareButton) forControlEvents:UIControlEventTouchUpInside];
    
    myImage2 = [UIImage imageNamed:@"icons8-Home Filled"];
    UIButton *myButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton3 setImage:myImage2 forState:UIControlStateNormal];
    myButton3.frame = CGRectMake(10.0,0.0,80.0,24.0);
    [myButton3 addTarget:self action:@selector(tappedShareButt) forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithCustomView:myButton2];
    UIBarButtonItem *rightButton3 = [[UIBarButtonItem alloc] initWithCustomView:myButton3];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:leftButton1,rightButton2,rightButton3, nil];
    
}


-(void)tapped
{
    
}
-(void)tappedShareButton
{
    
}

-(void)tappedShareButt
{
    
}

// Custom height of Tabbar controller method
- (void)viewWillLayoutSubviews
{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 60;
    tabFrame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = tabFrame;
}
@end
