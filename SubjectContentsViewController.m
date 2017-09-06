

#import "SubjectContentsViewController.h"
#import "SwicthChildViewController.h"
#import "SubContentSkillCell.h"
#import "SubContentSkillModelData.h"
#import <WYPopoverController.h>
@interface SubjectContentsViewController ()<WYPopoverControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIImage *myImage;
    UIImage *switchChildImage;
    SwicthChildViewController *switchVC;
    WYPopoverController *wypopOverController;
    
    SubContentSkillModelData *subContSkillModelData;
    NSMutableArray *subContSkillTabArr;
    
}
@property (weak, nonatomic) IBOutlet UIButton *playAllButtonOutlet;
- (IBAction)playAllButtonAction:(UIButton *)sender;

@end

@implementation SubjectContentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title =[self.subjectContentsName uppercaseString];
    
    // Setting corner of Buy button
    self.playAllButtonOutlet.layer.cornerRadius = 5;
    self.playAllButtonOutlet.backgroundColor = [UIColor colorWithRed:0.41 green:0.31 blue:0.72 alpha:1.0];
    [self customBackButton];
    [self CustomRightButton];
    
    subContSkillTabArr = [[NSMutableArray alloc]init];
    [self subContentSkillData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// Custom right button
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

// Custom right button action
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


// Play all button action
- (IBAction)playAllButtonAction:(UIButton *)sender
{
    
}
// Collection view Delegate methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [subContSkillTabArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"subContentSkillCell";
    
    SubContentSkillCell *cell = (SubContentSkillCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    subContSkillModelData = subContSkillTabArr[indexPath.row];
    cell.subContentSkillName.text = subContSkillModelData.subContentsSkillName;
    cell.subContentSkillImage.image =  subContSkillModelData.subContentsSkillImage;
    cell.subContentSkillPriceDetail.text = subContSkillModelData.subContentsSkillPriceDetail;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat padding = 50;
    CGFloat cellSize = collectionView.frame.size.width - padding;
    return CGSizeMake(cellSize / 2, cellSize / 2);
}

// Sub-Content Skill local data method
-(void)subContentSkillData
{
    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 1";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1169"];
    [subContSkillTabArr addObject:subContSkillModelData];
    
    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 2";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1169"];
    [subContSkillTabArr addObject:subContSkillModelData];
    
    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 3";
    subContSkillModelData.subContentsSkillPriceDetail =@"10 days for expiry";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1171"];
    [subContSkillTabArr addObject:subContSkillModelData];

    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 4";
    subContSkillModelData.subContentsSkillPriceDetail =@"20 days for expiry";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1171"];
    [subContSkillTabArr addObject:subContSkillModelData];
    
    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 5";
    subContSkillModelData.subContentsSkillPriceDetail =@"INR 10 per month";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1170"];
    [subContSkillTabArr addObject:subContSkillModelData];

    subContSkillModelData=[[SubContentSkillModelData alloc]init];
    subContSkillModelData.subContentsSkillName= @"Skill 6";
    subContSkillModelData.subContentsSkillPriceDetail =@"INR 10 per month";
    subContSkillModelData.subContentsSkillImage = [UIImage imageNamed:@"Group 1170"];
    [subContSkillTabArr addObject:subContSkillModelData];
}
@end
