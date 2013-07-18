//
//  AppDelegate.h
//  uih
//
//  Created by 才国 on 13-6-20.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yejhd.h"
#import "FileHelpers.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString * webcode;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString  *webcode;
@property (nonatomic, retain) NSString  *username;

@end
