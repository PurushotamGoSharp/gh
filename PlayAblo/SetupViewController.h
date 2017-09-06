

#import <UIKit/UIKit.h>
#include "SetUpTableViewCell.h"
#import "FRHyperLabel.h"

@interface SetupViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UISegmentedControl *Board;
@property (strong, nonatomic) IBOutlet UIButton *firstStandard;
@property (strong, nonatomic) IBOutlet UIButton *secondStandard;
@property (strong, nonatomic) IBOutlet UIButton *thirdStandard;
@property (strong, nonatomic) IBOutlet UIButton *fourthStandard;
@property (strong, nonatomic) IBOutlet UIButton *fifthStandard;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (strong, nonatomic) IBOutlet UITextField *childName;
@property (strong, nonatomic) IBOutlet UITextField *CityName;
@property (strong, nonatomic) IBOutlet UITextField *schoolName;
@property (strong, nonatomic) IBOutlet UIButton *playingBtn;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;

@property (strong, nonatomic) IBOutlet UITableView *schoolTableView;
@property (strong, nonatomic) IBOutlet FRHyperLabel *termsLbl;

@end
