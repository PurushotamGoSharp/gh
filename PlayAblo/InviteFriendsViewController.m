

#import "InviteFriendsViewController.h"

@interface InviteFriendsViewController ()
- (IBAction)whatsUpShareButtonAction:(UIButton *)sender;
- (IBAction)facebookShareButtonAction:(UIButton *)sender;
- (IBAction)twitterShareButtonAction:(UIButton *)sender;
- (IBAction)instagramShareButtonAction:(UIButton *)sender;
- (IBAction)googlePlusSahreButtonAction:(UIButton *)sender;

@end

@implementation InviteFriendsViewController
{
    UIImage *myImage;
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
    self.navigationItem.title =@"Share with Friends";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    // Calling custom button method
    [self customBackButton];
    
}

// Custom back button
-(void)customBackButton
{
    myImage = [UIImage imageNamed:@"back_Arrow"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    
    
    myButton.frame = CGRectMake(10.0, 0.0,24, 24);
    [myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

// Custom back button action
-(void)tapped
{
    [self.navigationController popViewControllerAnimated:YES];
}



// Whats-Up share button action
- (IBAction)whatsUpShareButtonAction:(UIButton *)sender
{
    [self whatsUpShareAlertMessage];

}

// Facebook share button action
- (IBAction)facebookShareButtonAction:(UIButton *)sender
{
     [self facebookShareAlertMessage];
}

// Twitter share button action
- (IBAction)twitterShareButtonAction:(UIButton *)sender
{
     [self twitterShareAlertMessage];
}

// Instagram share button action
- (IBAction)instagramShareButtonAction:(UIButton *)sender
{
     [self instagramShareAlertMessage];
}

// Google-Plus share button action
- (IBAction)googlePlusSahreButtonAction:(UIButton *)sender
{
     [self googlePlusShareAlertMessage];
}

// Whats-Up share with friends alert message
-(void)whatsUpShareAlertMessage
{
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!"  message:@"Do you want to share with your WhatsUp friends ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here….
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// Facebook share with friends alert message
-(void)facebookShareAlertMessage
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!"  message:@"Do you want to share with your Facebook friends ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here….
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// Twitter share with friends alert message
-(void)twitterShareAlertMessage
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!"  message:@"Do you want to share with your Twitter friends ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here….
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// Instagram share with friends alert message
-(void)instagramShareAlertMessage
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!"  message:@"Do you want to share with your Instagram friends ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here….
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// Google-Plus share with friends alert message
-(void)googlePlusShareAlertMessage
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!"  message:@"Do you want to share with your Google+ friends ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here…
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //code here….
    }];
    [ok setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [cancel setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [alertController.view setTintColor:[UIColor yellowColor]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
