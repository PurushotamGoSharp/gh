

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "SettingsModelData.h"
#import "RateUs.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    // Model data and array object declaration
    NSMutableArray *profileSettingTabArray;
    SettingsModelData *pModel;
    RateUs *detail;
}
@property (weak, nonatomic) IBOutlet UITableView *profileSettingTavleViewOutlet;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Mutable array memory allocation declaration
    profileSettingTabArray = [[NSMutableArray alloc]init];
    
    // Profile-Setting data method is calling
    [self profileSettingData];
    
    self.profileSettingTavleViewOutlet.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Unhide navigation controller and navigation title
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title =@"Settings";
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
    
    SettingsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"profileSettingCell" forIndexPath:indexPath];
    
    pModel=profileSettingTabArray[indexPath.row];
    cell.profileSettingCellLabelString.text=pModel.settingString;
    cell.profileSettingCellImage.image=pModel.settingImage;
    tableView.tableFooterView=[UIView new];
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = v;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row == 0)
    {
         [self performSegueWithIdentifier:@"editProfileView" sender:indexPath];
        
    }
    else if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"memeberShipView" sender:indexPath];
    }
    else if(indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"inviteFriendsView" sender:indexPath];
    }
    else if(indexPath.row == 3)
    {
        if (detail==nil)
        {
            detail=[[RateUs alloc]initWithFrame:CGRectMake(10, 10, 360, 360)];
            detail.delegate = self;
            
        }
        
        [detail alphaintialiseview];
    }
    else if(indexPath.row == 4)
    {
         [self performSegueWithIdentifier:@"avoutusView" sender:indexPath];
    }
    else if(indexPath.row == 5)
    {
//         [self performSegueWithIdentifier:@"avoutusView" sender:indexPath];
        
    }
    else if(indexPath.row == 6)
    {
        //[self performSegueWithIdentifier:@"settings" sender:indexPath];
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
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"Account Details";
    pModel.settingImage = [UIImage imageNamed:@"businessman-showing-calculator"];
    [profileSettingTabArray addObject:pModel];
    
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"Membership Details";
    pModel.settingImage = [UIImage imageNamed:@"id-card-1"];
    [profileSettingTabArray addObject:pModel];
    
    
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"Invite Friends";
    pModel.settingImage = [UIImage imageNamed:@"wedding-invitation-1"];
    [profileSettingTabArray addObject:pModel];
    
    
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"Rate Us";
    pModel.settingImage = [UIImage imageNamed:@"customer"];
    [profileSettingTabArray addObject:pModel];
    
    
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"About Us";
    pModel.settingImage = [UIImage imageNamed:@"professor-lecture-about-graduation"];
    [profileSettingTabArray addObject:pModel];
    
    pModel = [[SettingsModelData alloc]init];
    pModel.settingString = @"Log Out";
    pModel.settingImage = [UIImage imageNamed:@"power-button"];
    [profileSettingTabArray addObject:pModel];
    
}

@end
