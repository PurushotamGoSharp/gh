

#import "SubjectViewController.h"
#import "SubjectPrice.h"
#import "SubjectContentCell.h"
#import "SubjectContentModelData.h"
#import "SwicthChildViewController.h"
#import <WYPopoverController.h>
#import "SubjectContentsViewController.h"

@interface SubjectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WYPopoverControllerDelegate>
{
    UIImage *myImage;
    SubjectPrice *detail;
    SubjectContentModelData *subContModelData;
    NSMutableArray *subContTabArr;
    UIImage *switchChildImage;
    SwicthChildViewController *switchVC;
    WYPopoverController *wypopOverController;

    
}
@property (weak, nonatomic) IBOutlet UIButton *buyMathematicsButtonOutlet;
- (IBAction)BuyMathematicsButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *buyMathematicsMsgLabel;
@property (weak, nonatomic) IBOutlet UIButton *subjectPriceLabel;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
    self.navigationItem.title =self.subjectName;
    NSString *subPrice =@"@INR 170";
    NSString *subPriceStringValue = [NSString stringWithFormat: @"Buy %@ %@",
                          _subjectName, subPrice];
    NSLog(@"Subject Price:%@",subPriceStringValue);
    
    self.buyMathematicsMsgLabel.text = subPriceStringValue;
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    // Setting corner of Buy button
    self.buyMathematicsButtonOutlet.layer.cornerRadius = 5;
    self.buyMathematicsButtonOutlet.backgroundColor = [UIColor colorWithRed:0.41 green:0.31 blue:0.72 alpha:1.0];
    // Calling custom button method
    [self customBackButton];
    
    subContTabArr = [[NSMutableArray alloc]init];
    [self subContentData];
    [self CustomRightButton];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
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


// Collection view Delegate methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [subContTabArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"subContentCell";
    
    SubjectContentCell *cell = (SubjectContentCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    subContModelData = subContTabArr[indexPath.row];
    cell.subContentName.text = subContModelData.subContentsName;
    cell.subContentImage.image =  subContModelData.subContentsImage;
    cell.subContentsPriceDetails.text = subContModelData.subContentsPriceDetail;
    cell.subContentLockImage.image = subContModelData.subContentsLockImage;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectContentsViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"subContentsVW"];
    subContModelData=subContTabArr[indexPath.row];
    dvc.subjectContentsName= subContModelData.subContentsName;
    [self.navigationController pushViewController:dvc animated:YES];
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat padding = 50;
    CGFloat cellSize = collectionView.frame.size.width - padding;
    return CGSizeMake(cellSize / 2, cellSize / 2);
}

- (IBAction)BuyMathematicsButtonAction:(UIButton *)sender
{
    if (detail==nil)
    {
        detail=[[SubjectPrice alloc]initWithFrame:CGRectMake(10, 10, 360, 300)];
        detail.delegate = self;
        
    }
    detail.subjectName = self.subjectName;
    
    [detail alphaintialiseview];
}

// Sub-Content local data method
-(void)subContentData
{
    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Addition";
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1169"];
    [subContTabArr addObject:subContModelData];
    
    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Subtraction";
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1172"];
    [subContTabArr addObject:subContModelData];
    

    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Multiplication";
    subContModelData.subContentsPriceDetail= @"INR 10 per month";
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1171"];
    [subContTabArr addObject:subContModelData];
    

    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Division";
    subContModelData.subContentsPriceDetail= @"INR 10 per month";
    subContModelData.subContentsLockImage=[UIImage imageNamed:@"M0rpUd_2_"];
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1170"];
    [subContTabArr addObject:subContModelData];
    

    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Factorial";
    subContModelData.subContentsPriceDetail= @"INR 10 per month";
    subContModelData.subContentsLockImage=[UIImage imageNamed:@"M0rpUd_2_"];
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1170"];
    [subContTabArr addObject:subContModelData];
    

    subContModelData=[[SubjectContentModelData alloc]init];
    subContModelData.subContentsName= @"Number";
    subContModelData.subContentsPriceDetail= @"INR 10 per month";
    subContModelData.subContentsLockImage=[UIImage imageNamed:@"M0rpUd_2_"];
    subContModelData.subContentsImage = [UIImage imageNamed:@"Group 1170"];
    [subContTabArr addObject:subContModelData];
}
@end
