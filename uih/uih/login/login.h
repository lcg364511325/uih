//
//  login.h
//  uih
//
//  Created by moko on 13-7-16.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"
#import "LoginEntity.h"
#import "AppDelegate.h"
#import "myhome.h"

@interface login : UIViewController<UIAlertViewDelegate>


@property (nonatomic , strong) IBOutlet UITextField* UserName;
@property (nonatomic , strong) IBOutlet UITextField * UserPWD;
@property (nonatomic , strong) IBOutlet UITextField * Lcode;

-(IBAction)openUrl:(id)sender;

@end
