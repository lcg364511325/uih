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
#import "NewsContent.h"
#import "YGPSegmentedController.h"
#import "login.h"

@interface Yejhd : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate, UITabBarControllerDelegate,UIAlertViewDelegate,YGPSegmentedControllerDelegate>
{
    NSMutableArray * lists;
    NSMutableArray * newLists;
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


@end
