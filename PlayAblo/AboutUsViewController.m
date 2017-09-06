//
//  AboutUsViewController.m
//  PlayAblo
//
//  Created by Purushottam Kumar on 06/09/17.
//  Copyright © 2017 Go Sharp Technologies Pvt. Ltd. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
{
    UIImage *myImage;
}
@property (weak, nonatomic) IBOutlet UIWebView *aboutUsWebView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // URL of company website
    NSString *urlString=@"https://www.playablo.com/";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_aboutUsWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title =@"About Us";
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


@end
