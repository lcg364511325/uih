//
//  myhome.m
//  uih
//
//  Created by moko on 13-7-17.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "myhome.h"

@interface myhome ()

@end

@implementation myhome

@synthesize nickname;
@synthesize others;
@synthesize desiredate;
@synthesize desire;
@synthesize headimg;
@synthesize scrollview;

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
    
    [self reload];
}

- (void)myInit
{
    //设置标题
    self.title=@"家园互动平台";
    
    self.scrollview.contentSize = CGSizeMake(340.0,750.0);
    
    //设置导航栏底图
    [self.navigationController.navigationBar setBackgroundImage:[Tool headbg] forBarMetrics:UIBarMetricsDefault];
    [self.view setBackgroundColor:[Tool getBackgroundColor]];
    
    //定制导航栏左按钮
    UIImage* image= [UIImage imageNamed:@""];
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
    image= [UIImage imageNamed:@"exit"];
    frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnHome= [[UIButton alloc] initWithFrame:frame_1];
    [btnHome setBackgroundImage:image forState:UIControlStateNormal];
    [btnHome setTitle:@"" forState:UIControlStateNormal];
    [btnHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnHome.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnHome addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
     BarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btnHome];
    self.navigationItem.rightBarButtonItem = BarButtonItem;
    
    
    //给UIImageView添加事件响应
    self.headimg.userInteractionEnabled = YES;  //必须为YES才能响应事件
    UITapGestureRecognizer *singleTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goprofile)];
    [self.headimg addGestureRecognizer:singleTouch];
    
    
    
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    self.scrollview.contentSize = CGSizeMake(340.0,750.0);
//}

- (void)reload
{
    
    @try {
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        DataService * ds = [[DataService alloc] init];
        
        ProfileEntity * obj = [ds schoolPersonnel:myDelegate.username];
        if(obj){
            NSString * Sexual=obj.Sexual;
            NSString * Sexualname=@"男孩";
            NSMutableString* sexstr=[NSMutableString stringWithFormat:@"1"];
            if([sexstr isEqualToString:Sexual]){
                Sexualname=@"女孩";
            }
            
            self.nickname.text=[NSString stringWithFormat:@"%@ 小小世界",obj.PetName];
            self.others.text=[NSString stringWithFormat:@"全名：%@   %@  %@",obj.RealName,obj.Constellation,Sexualname];
            
            
            NSURL *imgUrl=[NSURL URLWithString:obj.PortraitPath];
            if (hasCachedImage(imgUrl)) {
                
                [self.headimg setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
                
            }else
            {
                
                [self.headimg setImage:[UIImage imageNamed:@"wenhao"]];
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",self.headimg,@"imageView",nil];
                [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
                
            }

            
        }
        
        DesireEntity * desi = [ds newDesire:myDelegate.username];
        if(desi){
                        
            self.desiredate.text=[desi.ReleaseDate substringToIndex:10];
            self.desire.text=[NSString stringWithFormat:@"%@",desi.DesireContent];
        }
 
        
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    
}

- (void)logout
{
    //清除登录缓存值
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
}

//进入个人资料页面
-(void)goprofile
{
    NSLog(@"-----ssssssssssss");
}

//进入我的愿望列表
-(void)godesirelist:(id)sender
{
    NSLog(@"----eeeeeeeee");
    
}

//进入其它的功能页面
-(void)gootherpage:(id)sender
{
    UIButton *button = (UIButton *)sender;  //参数id是一个通用内型，此处将其强制转换成UIButton内型
    //每个button都有唯一的tag，系统默认陪标示用的，是一个整数
    //NSString *title =[NSString stringWithFormat:@"Button tag %d",button.tag];//将button tag 转换成字符串输出
    
    int tag=button.tag;
    
    NSLog(@"-------%d",tag);
    
    switch (tag) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            
            break;
        case 11:
            
            break;
        case 12:
            
            break;
        default:
            break;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
