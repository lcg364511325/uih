//
//  Yejhd.m
//  uih
//
//  Created by 陈 星 on 13-7-6.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "Yejhd.h"

@interface Yejhd ()

@end

@implementation Yejhd
@synthesize tableLists;
static int typeid=1;

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
    
    [self myInit];
    
    //下拉刷新
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -320.0f, self.view.frame.size.width, 320)];
        view.delegate = self;
        [self.tableLists addSubview:view];
        _refreshHeaderView = view;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    
    lists = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self reload:YES];
}

- (void)myInit
{
    //设置标题
    self.title = @"育儿宝典";
    
    //设置导航栏底图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
    
    //定制导航栏左按钮
    UIImage* image= [UIImage imageNamed:@"return"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* btnBack= [[UIButton alloc] initWithFrame:frame_1];
    [btnBack setBackgroundImage:image forState:UIControlStateNormal];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [btnHome addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    
    BarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btnHome];
    self.navigationItem.rightBarButtonItem = BarButtonItem;

    Page = 1;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)home
{
    
}

- (void)clear
{
    [lists removeAllObjects];
    isLoadOver = NO;
}

- (void)reload:(BOOL)noRefresh
{
    if (!noRefresh) {
        Page = 1;
    }
    
    if (isLoading || isLoadOver) {
        return;
    }
    isLoading = YES;
    
    @try {
        DataService * ds = [[DataService alloc] init];
    
        NSMutableArray * newLists = [ds GetNews_yejhd:Page typeid:typeid];
    
        if (newLists.count < 1) {
            isLoadOver = YES;
        }
        isLoading = NO;
        if (!noRefresh) {
            [self clear];
        }
        [lists addObjectsFromArray:newLists];
        [self.tableLists reloadData];
        //[self doneLoadingTableViewData];
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        isLoading = NO;
        [self doneLoadingTableViewData];
    }
    
}


-(IBAction)onclickNewsType:(id)sender{
    
    UIButton *button = (UIButton *)sender;  //参数id是一个通用内型，此处将其强制转换成UIButton内型
    //每个button都有唯一的tag，系统默认陪标示用的，是一个整数
    //NSString *title =[NSString stringWithFormat:@"Button tag %d",[button tag]];//将button tag 转换成字符串输出
    NSString *mesage = [button currentTitle];     //取得button名称
    NSLog(@"--------------:%@",mesage);
    
    [self clear];
    
    if ([mesage hasPrefix:@"养儿冏好大"]) {
        typeid=5;
        [self reload:YES];
    }else if ([mesage hasPrefix:@"育儿好望角"]){
        typeid=4;
        [self reload:YES];
    }else if ([mesage hasPrefix:@"特色教学"]){
        typeid=2;
        [self reload:YES];
    }else {
        typeid=1;
        [self reload:YES];
    
    }
    
}

- (void)doneManualRefresh
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:self.tableLists];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableLists];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma TableView的处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lists.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [Tool getCellBackgroundColor];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier   = @"listCell";
    
    if ([lists count] > 0) {
        if ([indexPath row] < [lists count])
        {
                YejhdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) {
                    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"YejhdCell" owner:self options:nil];
                    for (NSObject *o in objects) {
                        if ([o isKindOfClass:[YejhdCell class]]) {
                            cell = (YejhdCell *)o;
                            break;
                        }
                    }
                }
            
                cell.lblTitle.font = [UIFont boldSystemFontOfSize:13.0];
                
                NewsEntity * n = [lists objectAtIndex:[indexPath row]];
                cell.lblTitle.text = n.ArticleTitle;
             
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;        }
        else
        {
            return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"已经加载完毕" andLoadingString:(isLoading ? loadingTip : loadNext20Tip) andIsLoading:isLoading];
        }
    }
    else
    {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:isLoadOver andLoadOverString:@"已经加载完毕" andLoadingString:(isLoading ? loadingTip : loadNext20Tip) andIsLoading:isLoading];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int row = [indexPath row];
    if (row >= [lists count]) {
        if (!isLoading) {
            [self performSelector:@selector(reload:)];
        }
    }
    else {

        NewsEntity *n = [lists objectAtIndex:row];
        if (n)
        {
            //NewsDetail *nDetail = [[NewsDetail alloc] init];
            //nDetail.newsID = n._id;
            //nDetail.isNextPage = NO;
                
            //[self.navigationController pushViewController:nDetail animated:NO];

        }
    }
}


#pragma 下提刷新
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableLists];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self refresh];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}
- (void)refresh
{
    isLoadOver = NO;
    [self reload:NO];
}


@end
