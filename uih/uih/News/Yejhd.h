//
//  Yejhd.h
//  uih
//
//  Created by 陈 星 on 13-7-6.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"
#import "DataService.h"
#import "YejhdCell.h"
#import "NewsEntity.h"

@interface Yejhd : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate, UITabBarControllerDelegate,UIAlertViewDelegate>
{
    NSMutableArray * lists;
    BOOL isLoading;
    BOOL isLoadOver;
    int Page;
    
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    
}

@property (strong, nonatomic) IBOutlet UITableView * tableLists;

- (void)reload:(BOOL)noRefresh;

- (void)clear;  //清空

- (void)myInit;

-(void)reloadTableViewDataSource;

-(void)doneLoadingTableViewData;

-(IBAction)onclickNewsType:(id)sender;

@end
