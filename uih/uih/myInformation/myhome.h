//
//  myhome.h
//  uih
//
//  Created by moko on 13-7-17.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"
#import "DesireEntity.h"
#import "ProfileEntity.h"
#import "AppDelegate.h"
#import "FileHelpers.h"
#import "ImageCacher.h"
#import "baseInformation.h"

@interface myhome : UIViewController


@property (nonatomic , strong) IBOutlet UILabel * nickname;
@property (nonatomic , strong) IBOutlet UILabel * others;
@property (nonatomic,strong)IBOutlet UILabel * desiredate;
@property (nonatomic , strong) IBOutlet UILabel * desire;
@property (nonatomic , strong) IBOutlet UIImageView * headimg;
@property (nonatomic , strong) IBOutlet UIScrollView * scrollview;


-(IBAction)godesirelist:(id)sender;
-(IBAction)gootherpage:(id)sender;



@end
