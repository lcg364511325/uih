//
//  baseInformation.m
//  uih
//
//  Created by moko on 13-7-23.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "baseInformation.h"

@interface baseInformation ()
{
YGPSegmentedController * _ygp;
}
@end

static int typeid=0;//选择的第几个
static NSString  * Sexual=0;//性别（1是女--true，0是男--false）
static NSString  *  BloodType=0;//血型(1 --A型,2 --B型,3 --AB型,4 --O型)
static NSString  * Birthday;//日期
static int selecttype=0;//0性别 1血型
static NSArray *selectvalue;//存放选择对应的值

@implementation baseInformation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self myInit];
}


- (void)myInit
{
    //设置标题
    self.title = @"个人资料维护";
    
    //设置导航栏底图
    [self.navigationController.navigationBar setBackgroundImage:[Tool headbg] forBarMetrics:UIBarMetricsDefault];
    [self.view setBackgroundColor:[Tool getBackgroundColor]];
    
    //定制导航栏左按钮
    UIImage* image= [UIImage imageNamed:@"back"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem * BarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = BarButtonItem;
    
    //定制导航栏右按钮
    image= [UIImage imageNamed:@"keep"];
    frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnSave= [[UIButton alloc] initWithFrame:frame_1];
    [btnSave setBackgroundImage:image forState:UIControlStateNormal];
    [btnSave setTitle:@"" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSave.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnSave addTarget:self action:@selector(savepro) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * BarButtonItem1= [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    ///self.navigationItem.rightBarButtonItem = BarButtonItem;
    
    //定制导航栏右按钮
    image= [UIImage imageNamed:@"home"];
    frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnHome= [[UIButton alloc] initWithFrame:frame_1];
    [btnHome setBackgroundImage:image forState:UIControlStateNormal];
    [btnHome setTitle:@"" forState:UIControlStateNormal];
    [btnHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnHome.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnHome addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * BarButtonItem2= [[UIBarButtonItem alloc] initWithCustomView:btnHome];
    //self.navigationItem.rightBarButtonItem = BarButtonItem;
    
    NSArray * buttonlArray = [NSArray arrayWithObjects:BarButtonItem2, BarButtonItem1, nil];
    
    self.navigationItem.rightBarButtonItems=buttonlArray;
    
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithObjects:@"基本资料", @"学籍资料", @"账号管理", @"头像照片", nil];
    
    /*
     第一个参数是存放你需要显示的title
     第二个是设置你需要的size
     */
    _ygp = [[YGPSegmentedController alloc]initContentTitle:TitielArray buttonwidth:80 CGRect:CGRectMake(0, 0, 320, 44)];
    
    [_ygp setDelegate:self];
    
    [self.view addSubview:_ygp];
    
    
    
    self.flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = @"选择日期";
    self.flatDatePicker.datePickerMode = FlatDatePickerModeDate;
    
    
    [self initInputViewBackground];
    
    [self setshowValue];
    
    [self showHideView];

}

//设置显示的基本资料值
-(void) setshowValue{

    _RealName.text=_proEntity.RealName;
    _PetName.text=_proEntity.PetName;
    _agedatebutton.titleLabel.text=_proEntity.Birthday;
    
    _sexbutton.titleLabel.text=@"男";
    if(_proEntity.Sexual>0){
        _sexbutton.titleLabel.text=@"女";
    }
    _bloodbutton.titleLabel.text=[self getbloodname:_proEntity.BloodType];
    
    _Telphone.text=_proEntity.Telphone;
    _Address.text=_proEntity.Address;
    _Email.text=_proEntity.Email;
    _HomeTel.text=_proEntity.HomeTel;
    _PersonCode.text=_proEntity.PersonCode;
    _JoinDate.text=_proEntity.JoinDate;
    _UserDescribe.text=_proEntity.UserDescribe;
    _Constellation.text=_proEntity.Constellation;
    
    NSURL *imgUrl=[NSURL URLWithString:_proEntity.PortraitPath];
    if (hasCachedImage(imgUrl)) {
        
        [self.PortraitPath setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        
    }else
    {
        
        [_PortraitPath setImage:[UIImage imageNamed:@"wenhao"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",_PortraitPath,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存个人信息
- (void)savepro
{
    switch (typeid) {
        case 0:
            _proEntity.RealName=_RealName.text;
            _proEntity.PetName=_PetName.text;
            _proEntity.Birthday=Birthday;
            _proEntity.Sexual=Sexual;
            _proEntity.BloodType=BloodType;
            _proEntity.Telphone=_Telphone.text;
            _proEntity.Address=_Address.text;
            _proEntity.Email=_Email.text;
            
            break;
         case 2:
            //修改密码
            
            
            break;
        case 3:
            //上传头像
            
            
            break;
        default:
            break;
    }
    
    
    
    
}

- (void)home
{
    myhome *aloc = [[myhome alloc] init];
    
    [self.navigationController pushViewController:aloc animated:NO];
    
}


-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl == _ygp) {
        NSLog(@"segmentedControl.index :%d",index);
        
        switch (index) {
            case 0:
                typeid=0;
                
                break;
            case 1:
                typeid=1;
                
                break;
            case 2:
                typeid=2;
                
                break;
            case 3:
                typeid=3;
                
                break;
            default:
                break;
        }
        
        [self showHideView];
    }

    NSString * string = [NSString stringWithFormat:@"%d",index];
    
    NSLog(@"%@",string);
    
    
}

//初始化显示区域的效果
- (void)initInputViewBackground
{
    CALayer *baseInfoLayer = _baseInfoView.layer;
    [baseInfoLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [baseInfoLayer setBorderWidth:1];
    [baseInfoLayer setMasksToBounds:YES];
    [baseInfoLayer setCornerRadius:5];
    
    CALayer *schoolInfo = _schoolInfoView.layer;
    [schoolInfo setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [schoolInfo setBorderWidth:1];
    [schoolInfo setMasksToBounds:YES];
    [schoolInfo setCornerRadius:5];
    
    CALayer *passwordLayer = _passwordView.layer;
    [passwordLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [passwordLayer setBorderWidth:1];
    [passwordLayer setMasksToBounds:YES];
    [passwordLayer setCornerRadius:5];
    
    
    CALayer *headImageLayer = _headImageView.layer;
    [headImageLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [headImageLayer setBorderWidth:1];
    [headImageLayer setMasksToBounds:YES];
    [headImageLayer setCornerRadius:5];

}

//隐藏或者显示view
-(void)showHideView{

    

    [self.baseInfoView setHidden:true];
    [self.schoolInfoView setHidden:true];
    [self.passwordView setHidden:true];
    [self.headImageView setHidden:true];
    
    switch (typeid) {
        case 0:
            [self.baseInfoView setHidden:false];
            
            break;
        case 1:
            [self.schoolInfoView setHidden:false];
            break;
        case 2:
            [self.passwordView setHidden:false];

            break;
        case 3:
            [self.headImageView setHidden:false];

            break;
        default:
            break;
    }
    
    
}


//隐藏或者显示view
- (NSString *)getbloodname:(NSString *)bloodvalue
{
    //血型(1 --A型,2 --B型,3 --AB型,4 --O型)
    switch ([bloodvalue intValue]) {
        case 1:
            return @"A型";
        case 2:
            return @"B型";
        case 3:
            return @"AB型";
        case 4:
            return @"O型";
        default:
            return @"未知";
    }
}

#pragma mark - UIAction methods

- (IBAction)selectphotos:(id)sender
{
    
    
}

- (IBAction)dophotos:(id)sender
{
    
    
}
//选择性别
- (IBAction)sex:(id)sender
{
    pickerArray = [NSArray arrayWithObjects:@"男",@"女", nil];
    selectvalue = [NSArray arrayWithObjects:@"0",@"1", nil];
    
    if (defaultPickerView == nil) {
        defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,245,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"PickerGlass.png" title:@"选择数据"];
        defaultPickerView.dataSource = self;
        defaultPickerView.delegate = self;
        [self.view addSubview:defaultPickerView];
    }
    [defaultPickerView showPicker];
    [defaultPickerView reloadData];
    
    selecttype=0;//0性别 1血型
}
//选择血型
- (IBAction)blood:(id)sender
{
    //血型(1 --A型,2 --B型,3 --AB型,4 --O型)
    pickerArray = [NSArray arrayWithObjects:@"A型",@"B型",@"AB型",@"O型", nil];
    selectvalue = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    
    if (defaultPickerView == nil) {
        defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,245,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"PickerGlass.png" title:@"选择数据"];
        defaultPickerView.dataSource = self;
        defaultPickerView.delegate = self;
        [self.view addSubview:defaultPickerView];
    }
    [defaultPickerView showPicker];
    [defaultPickerView reloadData];
    
    selecttype=1;//0性别 1血型
}
//选择生日
- (IBAction)agedate:(id)sender
{
    [self.flatDatePicker show];
    
}


#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView {
    return [pickerArray count];
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row {
    return [pickerArray objectAtIndex:row]; 
}


#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row {
    
    //Sexual=0;//性别（1是女--true，0是男--false）
    //BloodType=0;//血型(1 --A型,2 --B型,3 --AB型,4 --O型)
    if(selecttype>0){
        //血型
        BloodType=[selectvalue objectAtIndex:row];
       
        _bloodbutton.titleLabel.text=[pickerArray objectAtIndex:row];
    }else{
    
        Sexual=[selectvalue objectAtIndex:row];
        _sexbutton.titleLabel.text=[pickerArray objectAtIndex:row];
        
    }
    
    NSLog(@"----------------:%d",row);
    
}

#pragma mark - FlatDatePicker Delegate

- (void)flatDatePicker:(FlatDatePicker*)datePicker dateDidChange:(NSDate*)date {
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[NSLocale currentLocale]];
    
    //if (datePicker.datePickerMode == FlatDatePickerModeDate) {
    //    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    //} else if (datePicker.datePickerMode == FlatDatePickerModeTime) {
    //    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //} else {
    //    [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    //}
    
    //[dateFormatter setDateFormat:@"yyyy MMMM dd"];
    
    //NSString *value = [dateFormatter stringFromDate:date];
    
    //Birthday = value;
    
    //_agedatebutton.titleLabel.text=Birthday;
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:@"Did cancelled !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alertView show];
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    //if (datePicker.datePickerMode == FlatDatePickerModeDate) {
    //    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    //} else if (datePicker.datePickerMode == FlatDatePickerModeTime) {
    //    [dateFormatter setDateFormat:@"HH:mm:ss"];
    ///} else {
    //    [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    //}
    [dateFormatter setDateFormat:@"yyyy MMMM dd"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    Birthday = value;
    
    _agedatebutton.titleLabel.text=Birthday;
    
    //NSString *message = [NSString stringWithFormat:@"Did valid date : %@", value];
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
