//
//  baseInformation.h
//  uih
//
//  Created by moko on 13-7-23.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"
#import "YGPSegmentedController.h"
#import "myhome.h"
#import "ProfileEntity.h"
#import "AFPickerView.h"
#import "FlatDatePicker.h"

@interface baseInformation : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate, UITabBarControllerDelegate,UIAlertViewDelegate,YGPSegmentedControllerDelegate,AFPickerViewDataSource, AFPickerViewDelegate,FlatDatePickerDelegate>
{
    AFPickerView *defaultPickerView;
    NSArray *pickerArray;
}


@property(retain , nonatomic) ProfileEntity * proEntity;
@property (nonatomic, strong) FlatDatePicker *flatDatePicker;

@property (retain, nonatomic) IBOutlet UIView *baseInfoView;
@property (retain, nonatomic) IBOutlet UIView *schoolInfoView;
@property (retain, nonatomic) IBOutlet UIView *passwordView;
@property (retain, nonatomic) IBOutlet UIView *headImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *authScrollView;

@property (retain, nonatomic) IBOutlet UITextField * RealName;
@property (retain, nonatomic) IBOutlet UITextField * PetName;
@property (retain, nonatomic) IBOutlet UITextField * Telphone;
@property (retain, nonatomic) IBOutlet UITextField * Address;
@property (retain, nonatomic) IBOutlet UITextField * Email;
@property (retain, nonatomic) IBOutlet UITextField * HomeTel;
@property (retain, nonatomic) IBOutlet UIImageView * PortraitPath;
@property (retain, nonatomic) IBOutlet UILabel * PersonCode;
@property (retain, nonatomic) IBOutlet UILabel * JoinDate;
@property (retain, nonatomic) IBOutlet UILabel * UserDescribe;
@property (retain, nonatomic) IBOutlet UITextField * Constellation;

@property (retain, nonatomic) IBOutlet UITextField * newpassword;
@property (retain, nonatomic) IBOutlet UITextField * againpassword;

@property (retain, nonatomic) IBOutlet UIButton * sexbutton;
@property (retain, nonatomic) IBOutlet UIButton * bloodbutton;
@property (retain, nonatomic) IBOutlet UIButton * agedatebutton;

- (IBAction)sex:(id)sender;
- (IBAction)blood:(id)sender;
- (IBAction)agedate:(id)sender;

- (IBAction)selectphotos:(id)sender;
- (IBAction)dophotos:(id)sender;


@end
