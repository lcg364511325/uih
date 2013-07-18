//
//  login.m
//  uih
//
//  Created by moko on 13-7-16.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "login.h"

@interface login ()

@end

@implementation login

@synthesize UserName;
@synthesize UserPWD;
@synthesize Lcode;

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
    self.title=@"家园互动平台登录";
    
    self.UserName.text=@"14013051504";
    self.UserPWD.text=@"q";
    
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
    image= [UIImage imageNamed:@"users"];
    frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnHome= [[UIButton alloc] initWithFrame:frame_1];
    [btnHome setBackgroundImage:image forState:UIControlStateNormal];
    [btnHome setTitle:@"登录" forState:UIControlStateNormal];
    [btnHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnHome.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnHome addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    BarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btnHome];
    self.navigationItem.rightBarButtonItem = BarButtonItem;

    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)login{

    @try {
        DataService * ds = [[DataService alloc] init];
        
        LoginEntity * obj = [ds login:self.UserName.text password:self.UserPWD.text verlity:self.Lcode.text];
        if(obj){
            if([obj.result isEqualToString:@"1"]){
                AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                myDelegate.webcode=obj.webcode;
                myDelegate.username=self.UserName.text;
                
                //登录成功，进入系统首页
                NSLog(@"登录成功，进入系统首页");
                myhome *my=[[myhome alloc] init];
                [self.navigationController pushViewController:my animated:NO];
                
            }else{
                NSString *info=obj.info;
                NSLog(@"ssdfdsfdsfsd------:%@",info);
                [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"帐号或者密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
            } 
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
}

-(void)openUrl:(id)sender
{
    
}

// 当点击软键盘的Enter键的时候进行回调
-(BOOL)textFieldShouldReturn
{
    NSLog(@"ssssssssssssss---------");
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
