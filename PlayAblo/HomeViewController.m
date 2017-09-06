

#import "HomeViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}
// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title =@"Home";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}


@end
