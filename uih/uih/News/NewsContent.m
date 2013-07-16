//
//  NewsContent.m
//  uih
//
//  Created by 才国 on 13-7-11.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "NewsContent.h"

@interface NewsContent ()

@end

@implementation NewsContent

@synthesize newid;

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
    self.title=@"育儿宝典";
    
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
    
    //WebView的背景颜色去除
    [Tool clearWebViewBackground:self.newsContent];
    
    [self.newsContent loadHTMLString:@"" baseURL:nil];
}

- (void)reload
{
    
    @try {
        DataService * ds = [[DataService alloc] init];
        
        NewsEntity * obj = [ds GetNews_content:newid];
        if(obj){
            self.newsTitle.text=obj.ArticleTitle;
            NSString * datestring=obj.OperatorDate;
            datestring=[datestring substringToIndex:10];
            self.newsTime.text=datestring;
            //self.newsContent.text=obj.ArticleContent;
            [self.newsContent loadHTMLString:obj.ArticleContent baseURL:nil];
        }  
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    
}



- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
