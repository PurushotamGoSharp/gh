

#import "SetupViewController.h"
#import "Constant.h"
#import "Postman.h"
#import "SetupModelData.h"
#import "AppDelegate.h"
#import "FRHyperLabel.h"
#import "SetUpGradeView.h"

@interface SetupViewController ()

@end

@implementation SetupViewController
{
    UIImage *myImage;
    NSMutableArray*userSignUpArray;
    NSString*childname,*selectedCity,*cityname,*schoolname,*selectedSchool;
    Postman*postman;
    SetupModelData*setupModel;
    NSMutableArray*boardArray,*boardSelectionArray,*gradeSelectionArray,*GenderArray,*cityArray,*schoolArray;
    SetUpGradeView*setUpGradeXib;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    _schoolName.delegate=self;
    _CityName.delegate=self;
    _childName.delegate=self;
    postman=[[Postman alloc]init];
    setupModel=[[SetupModelData alloc]init];
    userSignUpArray=[[NSMutableArray alloc]init];
    boardArray=[[NSMutableArray alloc]init];
    boardSelectionArray=[[NSMutableArray alloc]init];
    gradeSelectionArray=[[NSMutableArray alloc]init];
    GenderArray=[[NSMutableArray alloc]init];
    cityArray=[[NSMutableArray alloc]init];
    schoolArray=[[NSMutableArray alloc]init];
    _cityTableView.hidden=YES;
     _schoolTableView.hidden=YES;
    NSString*Termsstr=@"https://www.playablo.com/tandc.html";
    NSString*privacystr=@"https://www.playablo.com/privacy.html";
    
  
    
    NSString *string = @"By clicking on 'Start Playing' button below.I agree to the Terms and Condition and Privacy Policy of Playablo";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
    
    _termsLbl.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    
    [_termsLbl setLinkForSubstring:@"Terms and Condition" withLinkHandler:^(FRHyperLabel *label, NSString *substring){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Termsstr]]];
    }];
    [_termsLbl setLinkForSubstring:@"Privacy Policy" withLinkHandler:^(FRHyperLabel *label, NSString *substring){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",privacystr]]];
    }];
}


-(void)viewWillAppear:(BOOL)animated
{[super viewWillAppear:YES];
    UINavigationController*nc=(UINavigationController*)[[[UIApplication sharedApplication] delegate]window].rootViewController;
    [nc.navigationBar setBarTintColor:[UIColor colorWithRed:0.156 green:0.501 blue:0.631 alpha:1.0]];
    
     [self setDefault];
    [self callGetcityDetailapi];
    [self callgradeandBoardApi];
    
      if(!self.navigationItem.titleView){
        self.navigationItem.titleView = ({
            UILabel *titleView = [UILabel new];
            titleView.numberOfLines = 0;
            titleView.textAlignment = NSTextAlignmentCenter;
            titleView.attributedText = [[NSAttributedString alloc] initWithString:@"ADD PROFILE " attributes:self.navigationController.navigationBar.titleTextAttributes];
            
            [titleView sizeToFit];
            
            titleView;
        });
    }
   
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    [self customBackButton];
    NSString*userType=@"nonsocial";
    NSString*email=@"preettik@gmail.com";
    NSString*firstName=@"Preeti singh";
    NSString*passcode=@"power";
    NSString*mobilenumber=@"9109876546";
    [userSignUpArray addObject:userType];
    [userSignUpArray addObject:email];
    [userSignUpArray addObject:firstName];
    [userSignUpArray addObject:passcode];
    [userSignUpArray addObject:mobilenumber];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDefault{
selectedCity=@"";
}

// Custom back button
-(void)customBackButton
{
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setTitle:@"Delete" forState:UIControlStateNormal];
    
myButton.frame =CGRectMake(50, 10.0, 70, 50);
    [myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.rightBarButtonItem=leftButton;
}

// Custom back button action
-(void)tapped
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)setupProceedButtonAction:(UIButton *)sender
{
    childname=_childName.text;
    cityname=_CityName.text;
    schoolname=_schoolName.text;
    [self callRegisterApi];
      //[self performSegueWithIdentifier:@"tabView" sender:self];
    
    }
//Hide Keyboard after tap on return
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_childName resignFirstResponder];
    [_CityName resignFirstResponder];
    [_schoolName resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

-(void)callRegisterApi
{
    NSString*relationString=@"1";
    NSString*parameter;
    NSString* str1=[GenderArray componentsJoinedByString:@","];
    NSString* str2=[boardSelectionArray componentsJoinedByString:@","];
    NSNumber*boardNum=[NSNumber numberWithInteger:str2.integerValue];
    NSString* str3=[gradeSelectionArray componentsJoinedByString:@","];
    NSNumber*gradeNum=[NSNumber numberWithInteger:str3.integerValue];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,registerUser];
      NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary * dict1 = [[NSMutableDictionary alloc]init];
    dict[@"user_type_login"] = userSignUpArray[0];
    dict[@"EmailId"] = userSignUpArray[1];
    dict[@"Firstname"] = userSignUpArray[2];
    dict[@"Password"] = userSignUpArray[3];
    dict[@"mobile_number"] = userSignUpArray[4];
    dict[@"RelationTypeId"] =[NSNumber numberWithInteger:relationString.integerValue];
    dict[@"ConsumerKey"]= @"8633e742-e04f-4e41-9862-84102154d1ea";
    dict[@"ConsumerSecret"] = @"f5faa44f-dbc1-49c3-b746-2e55fe11c340";
    dict1[@"Gender"] = str1;
    dict1[@"BoardId"] = boardNum;
    dict1[@"GradeId"] = gradeNum;
    dict1[@"city_id"] = selectedCity;
    dict1[@"school_id"] = selectedSchool;
    dict1[@"FirstName"] = _childName.text;
    dict[@"ChildDetails"] =  dict1;
    NSData * paramdata = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    NSString * jsonParameter = [[NSString alloc]initWithData:paramdata encoding:NSUTF8StringEncoding];
    parameter =jsonParameter;
//parameter=[NSString stringWithFormat:@"{\"user_type_login\":\"%@\",\"EmailId\":\"%@\",\"Firstname\":\"%@\",\"Password\":\"%@\",\"mobile_number\":\"%@\",\"RelationTypeId\":1,\"ConsumerKey\":\"8633e742-e04f-4e41-9862-84102154d1ea\",\"ConsumerSecret\":\"f5faa44f-dbc1-49c3-b746-2e55fe11c340\",\"Gender\":\"%@\",\"BoardId\":%@,\"GradeId\":%@,\"city_id\":%@,\"school_id\":%@,\"FirstName\":\"%@\"}",userSignUpArray[0],userSignUpArray[1],userSignUpArray[2],userSignUpArray[3],userSignUpArray[4],str1,boardNum,gradeNum,selectedCity,selectedSchool,_childName.text];
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getRegisterResponseData:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
    
}
-(void)getRegisterResponseData:(NSDictionary *)parameterDict{
    
    
    
    
    
    
    
    
}
-(void)callgradeandBoardApi{
    NSString*parameter;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,getboardAndgrade];
    parameter=[NSString stringWithFormat:@"{\"user_email\":\"%@\",}",childname];
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
-(void)getResponseData:(NSDictionary *)parameterDict
{
    [boardArray removeAllObjects];
    NSLog(@"%@",parameterDict);
    NSDictionary *responseDict = parameterDict[@"data"];
    for (NSDictionary *dict1 in responseDict[@"Board"]){
        setupModel=[[SetupModelData alloc]init];
     if (dict1[@"board_id"]!=[NSNull null]){
            setupModel.boardId=dict1[@"board_id"];;
        }
        if (dict1[@"board_name"]!=[NSNull null]){
            setupModel.boardName=dict1[@"board_name"];;
        }
       [boardArray addObject:setupModel];
}
   for (NSDictionary *dict1 in responseDict[@"Grade"]){
        setupModel=[[SetupModelData alloc]init];
        setupModel.gradeId=dict1[@"grade_id"];
        setupModel.gradeName=dict1[@"grade_name"];
        setupModel.boardId= dict1[@"board_id"];
        [boardArray addObject:setupModel];
       
        }
    }

-(void)showAlerViewSuccess:(NSString*)msg
{
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"Alert!" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *success=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action)
                            {
                                
                                // Go in Set-Up view
                                [self performSegueWithIdentifier:@"tabView" sender:self];
                               [alertView dismissViewControllerAnimated:YES completion:nil];
                            }];
    [success setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    
    [alertView addAction:success];
    [self presentViewController:alertView animated:YES completion:nil];
}

// Signup success custom alert meassage method
-(void)showAlerViewFailure:(NSString*)msg
{
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"Alert!" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *success=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        
        
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [success setValue:[UIColor colorWithRed:255 green:.32 blue:.08 alpha:1] forKey:@"titleTextColor"];
    
    [alertView addAction:success];
    [self presentViewController:alertView animated:YES completion:nil];
}
- (IBAction)boardSelection:(id)sender {
    [boardSelectionArray removeAllObjects];
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    for (SetupModelData*m2 in boardArray) {
        if (selectedSegment == 0) {
            if ([m2.boardName isEqualToString:@"CBSE"]) {
                [boardSelectionArray addObject:m2.boardId];
                NSLog(@"%@",boardSelectionArray);
}
            }
else if ([m2.boardName isEqualToString:@"ICSE"]){
            [boardSelectionArray addObject:m2.boardId];
            NSLog(@"%@",boardSelectionArray);
        }
    }
    }
- (IBAction)fistGradeAction:(id)sender {
    
    [_firstStandard setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_firstStandard setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_firstStandard setTintColor:[UIColor redColor]];
    [_firstStandard setBackgroundColor:[UIColor orangeColor]];
    [gradeSelectionArray removeAllObjects];
    NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    if ([str isEqualToString:@"1"]) {
        for (SetupModelData*m1 in boardArray) {
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str1=[NSString stringWithFormat:@"%@",m1.gradeName];
            NSString *secondString = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*str2=@"1";
            if ([secondString isEqualToString:str2]&& [boardStr isEqualToString:str] ) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        }
    else if ([str isEqualToString:@"2"]){
        for (SetupModelData*m1 in boardArray) {
            NSString*gradeStr=[NSString stringWithFormat:@"%@", m1.gradeName];
            NSString *secondString = [gradeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str2=@"1";
            if ([secondString isEqualToString:str2] && [boardStr isEqualToString:str]) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        }
    }
- (IBAction)secondGradeAction:(id)sender {
    
    [_secondStandard setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_secondStandard setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_secondStandard setTintColor:[UIColor redColor]];
    [_secondStandard setBackgroundColor:[UIColor orangeColor]];

    [gradeSelectionArray removeAllObjects];
    NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    if ([str isEqualToString:@"1"]) {
        for (SetupModelData*m1 in boardArray) {
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str1=[NSString stringWithFormat:@"%@",m1.gradeName];
        NSString *secondString = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*str2=@"2";
            if ([secondString isEqualToString:str2]&& [boardStr isEqualToString:str] ) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }
    else if ([str isEqualToString:@"2"]){
        for (SetupModelData*m1 in boardArray) {
            NSString*gradeStr=[NSString stringWithFormat:@"%@", m1.gradeName];
            NSString *secondString = [gradeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str2=@"2";
            if ([secondString isEqualToString:str2] && [boardStr isEqualToString:str]) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }

}
- (IBAction)thirdGradeAction:(id)sender {
    
    [gradeSelectionArray removeAllObjects];
    NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    if ([str isEqualToString:@"1"]) {
        for (SetupModelData*m1 in boardArray) {
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str1=[NSString stringWithFormat:@"%@",m1.gradeName];
            
            NSString *secondString = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*str2=@"3";
            if ([secondString isEqualToString:str2]&& [boardStr isEqualToString:str] ) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }
    else if ([str isEqualToString:@"2"]){
        for (SetupModelData*m1 in boardArray) {
            NSString*gradeStr=[NSString stringWithFormat:@"%@", m1.gradeName];
            NSString *secondString = [gradeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str2=@"3";
            if ([secondString isEqualToString:str2] && [boardStr isEqualToString:str]) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }

}
- (IBAction)fourthGradeAction:(id)sender {
    [gradeSelectionArray removeAllObjects];
    NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    if ([str isEqualToString:@"1"]) {
        for (SetupModelData*m1 in boardArray) {
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str1=[NSString stringWithFormat:@"%@",m1.gradeName];
            
            NSString *secondString = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*str2=@"4";
            if ([secondString isEqualToString:str2]&& [boardStr isEqualToString:str] ) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }
    else if ([str isEqualToString:@"2"]){
        for (SetupModelData*m1 in boardArray) {
            NSString*gradeStr=[NSString stringWithFormat:@"%@", m1.gradeName];
            NSString *secondString = [gradeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str2=@"4";
            if ([secondString isEqualToString:str2] && [boardStr isEqualToString:str]) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }
}

- (IBAction)fifthGradeAction:(id)sender {
    [gradeSelectionArray removeAllObjects];
    NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    if ([str isEqualToString:@"1"]) {
        for (SetupModelData*m1 in boardArray) {
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str1=[NSString stringWithFormat:@"%@",m1.gradeName];
            
            NSString *secondString = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*str2=@"5";
            if ([secondString isEqualToString:str2]&& [boardStr isEqualToString:str] ) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }
    else if ([str isEqualToString:@"2"]){
        for (SetupModelData*m1 in boardArray) {
            NSString*gradeStr=[NSString stringWithFormat:@"%@", m1.gradeName];
            NSString *secondString = [gradeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString*boardStr=[NSString stringWithFormat:@"%@",m1.boardId];
            NSString*str2=@"5";
            if ([secondString isEqualToString:str2] && [boardStr isEqualToString:str]) {
                [gradeSelectionArray addObject:m1.gradeId];
                NSLog(@"%@",gradeSelectionArray);
            }
        }
        
    }

}
- (IBAction)GenderAction:(id)sender {
    [GenderArray removeAllObjects];
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        NSString*boyStr=@"M";
        [GenderArray addObject:boyStr];
        NSLog(@"%@",GenderArray);
}
    else{
        NSString*girlstr=@"F";
       [GenderArray addObject:girlstr];
       NSLog(@"%@",GenderArray);
    }
}

-(void)callGetcityDetailapi{
NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,getCityDetails];
[postman post:urlStr withParameter:@"" success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getCityResponseData:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
    
}
-(void)getCityResponseData:(NSDictionary *)parameterDict{
    NSLog(@"%@",parameterDict);
    NSArray*array= parameterDict[@"data"];
    for (NSDictionary *dict1 in array){
        setupModel=[[SetupModelData alloc]init];
        if (dict1[@"city_name"]!=[NSNull null]){
            setupModel.cityName=dict1[@"city_name"];;
        }
        if (dict1[@"city_id"]!=[NSNull null]){
            setupModel.cityId=dict1[@"city_id"];;
        }
        [cityArray addObject:setupModel];

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView])
    
    {
        return cityArray.count;
            }
    else {
        return schoolArray.count;
}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetUpTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
     if ([tableView isEqual:_cityTableView])
    {
        SetupModelData *model=cityArray[indexPath.row];
        cell.cityDisplayName.text=model.cityName;
    }
   else if ([tableView isEqual:_schoolTableView])
    {
        SetupModelData *model=schoolArray[indexPath.row];
        cell.schoolDisplayName.text=model.schoolName;
    }
    
      return cell;
}
- (IBAction)citySelectAction:(id)sender {
    [self.view endEditing:YES];
    [self hideTheViews:_CityName];

    [_cityTableView reloadData];
    [self callGetSchoolDetailapi];
}

-(void)hideTheViews:(UITextField*)text{
    
    if ([_CityName isEqual:text])
    {
        _cityTableView.hidden=NO;
        //_schoolTableView.hidden=NO;
        
    }
    else
    {
        _cityTableView.hidden=YES;
        //_schoolTableView.hidden=YES;
}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_cityTableView]){
    SetupModelData *model=cityArray[indexPath.row];
    _CityName.text=model.cityName;
     selectedCity=model.cityId;
    _cityTableView.hidden=YES;
    [self.view endEditing:YES];
}
    
    else if ([tableView isEqual:_schoolTableView])
    {
        SetupModelData *model=schoolArray[indexPath.row];
       _schoolName.text=model.schoolName;
        selectedSchool=model.schoolId;
        _schoolTableView.hidden=YES;
        [self.view endEditing:YES];
    }
}
///School Api
-(void)callGetSchoolDetailapi{
    NSString*parameter;
     NSString* str=[boardSelectionArray componentsJoinedByString:@","];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",playabloBaseUrl,getSchoolDetails];
    parameter=[NSString stringWithFormat:@"{\"BoardId\":\"%@\"}",str];
    [postman post:urlStr withParameter:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSData *responseData =[operation responseData];
         NSDictionary *parameterDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
         [self getSchoolResponseData:parameterDict];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
    
}
//Response of School Api
-(void)getSchoolResponseData:(NSDictionary*)parameterDict{
NSLog(@"%@",parameterDict);
    [schoolArray removeAllObjects];
    NSArray*array= parameterDict[@"data"];
    for (NSDictionary *dict1 in array){
        
        NSString*cityStr=[NSString stringWithFormat:@"%@",dict1[@"city_id"]];
        if ([[NSString stringWithFormat:@"%@",selectedCity] isEqualToString:cityStr]) {
            setupModel=[[SetupModelData alloc]init];
        if (dict1[@"school_name"]!=[NSNull null]){
         setupModel.schoolName=dict1[@"school_name"];;
        }
        if (dict1[@"school_id"]!=[NSNull null]){
            setupModel.schoolId =dict1[@"school_id"];;
        }
        [schoolArray addObject:setupModel];
        
    }
    }
 }
- (IBAction)schoolNmaAction:(id)sender {
    
    [self.view endEditing:YES];
    
//    [self hideTheViews:_schoolName];
     _schoolTableView.hidden=NO;
    [_schoolTableView reloadData];
}
- (IBAction)selectGradeAction:(id)sender {
   
    if (setUpGradeXib==nil)
    {
        setUpGradeXib=[[SetUpGradeView alloc]initWithFrame:CGRectMake(10, 10, 270, 150)];
    }
    [setUpGradeXib alphaintialiseview];

    
}

@end
