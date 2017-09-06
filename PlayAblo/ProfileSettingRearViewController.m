
#import "ProfileSettingRearViewController.h"
#import "ProfileRearModelData.h"
#import "ProfileSettingTableCell.h"
#import "SWRevealViewController.h"
#import "RateUs.h"

@interface ProfileSettingRearViewController ()<UITableViewDelegate,UITableViewDataSource,SWRevealViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *rateUSButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *inviteFriendsButtonOutlet;
@property (weak, nonatomic) IBOutlet UITableView *profileSettingTavleViewOutlet;

- (IBAction)reateUsButtonAction:(UIButton *)sender;

- (IBAction)inviteFriendsButtonAction:(UIButton *)sender;

@end

@implementation ProfileSettingRearViewController
{
    // Model data and array object declaration
    NSMutableArray *profileSettingTabArray;
    ProfileRearModelData *pModel;
     RateUs *detail;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Mutable array memory allocation declaration
    profileSettingTabArray = [[NSMutableArray alloc]init];
    
    // Profile-Setting data method is calling
    [self profileSettingData];
    
    
    // Rate-Us and Invite-Friends button corner setting
    self.rateUSButtonOutlet.layer.cornerRadius = 5;
    self.inviteFriendsButtonOutlet.layer.cornerRadius = 5;
    
    self.profileSettingTavleViewOutlet.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Heighlight Rate-Us and Invite-Friends custom method calling
    [self heiglistRateUsAndInviteFriendsButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
 
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
    
    
}

// TableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [profileSettingTabArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProfileSettingTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"profileSettingCell" forIndexPath:indexPath];
    
    pModel=profileSettingTabArray[indexPath.row];
    cell.profileSettingCellLabelString.text=pModel.profileSettingString;
    cell.profileSettingCellImage.image=pModel.profileSettingImage;
    tableView.tableFooterView=[UIView new];
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = v;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row == 7)
    {
        
        [self.revealViewController.navigationController  popToRootViewControllerAnimated:YES];
    }
    else if(indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"editProfileView" sender:indexPath];
        
    }
    else if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"memeberShipView" sender:indexPath];
    }
    else if(indexPath.row == 2)
    {
        //[self performSegueWithIdentifier:@"details" sender:indexPath];
    }
    else if(indexPath.row == 3)
    {
        //[self performSegueWithIdentifier:@"holidays" sender:indexPath];
    }
    else if(indexPath.row == 4)
    {
        //[self performSegueWithIdentifier:@"settings" sender:indexPath];
    }
    else if(indexPath.row == 5)
    {
        //[self performSegueWithIdentifier:@"spot4Me" sender:indexPath];
    }
    else if(indexPath.row == 6)
    {
        //[self performSegueWithIdentifier:@"aboutus" sender:indexPath];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
//    if ([segue.identifier isEqualToString:@"homeID"])
//    {
//        UINavigationController *nav = [segue destinationViewController];
//        TableFront *hm =(TableFront *)nav.topViewController;
//        NSIndexPath *indexpath = sender;
//        hm.aModel=array[indexpath.row];
//    }else if ([segue.identifier isEqualToString:@"contacts"])
//    {
//        
//    }
    
    
}





// Profile-Settings local data storage method
-(void)profileSettingData
{
    pModel = [[ProfileRearModelData alloc]init];
    pModel.profileSettingString = @"Account Settings";
    pModel.profileSettingImage = [UIImage imageNamed:@"locked"];
    [profileSettingTabArray addObject:pModel];
    
    pModel = [[ProfileRearModelData alloc]init];
    pModel.profileSettingString = @"Membership Details";
    pModel.profileSettingImage = [UIImage imageNamed:@"id-card"];
    [profileSettingTabArray addObject:pModel];

    
}

// Rate-Us button action
- (IBAction)reateUsButtonAction:(UIButton *)sender
{
    
    if (detail==nil)
    {
        detail=[[RateUs alloc]initWithFrame:CGRectMake(10, 10, 360, 360)];
        detail.delegate = self;
        
    }
   
    
    [detail alphaintialiseview];
}


// Invite-Friends button action
- (IBAction)inviteFriendsButtonAction:(UIButton *)sender
{
 
    [self performSegueWithIdentifier:@"inviteFriendsView" sender:self];
}


// Heighlight Rate-Us and Invite-Friends button method
-(void)heiglistRateUsAndInviteFriendsButton
{
     _rateUSButtonOutlet.showsTouchWhenHighlighted = YES;
     _inviteFriendsButtonOutlet.showsTouchWhenHighlighted = YES;
}
@end
