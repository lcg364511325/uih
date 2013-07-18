//
//  DataService.h
//  uih
//
//  Created by 陈 星 on 13-6-30.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsEntity.h"
#import "LoginEntity.h"
#import "ProfileEntity.h"
#import "DesireEntity.h"
#import "AppDelegate.h"

@interface DataService : NSObject


-(NSMutableArray*)GetNews_yejhd:(int)Page typeid:(int)typeid;

-(NewsEntity*)GetNews_content:(NSString *)newid;

-(LoginEntity*)login:(NSString *)username password:(NSString *)password verlity:(NSString*)verlity;

-(ProfileEntity*)schoolPersonnel:(NSString *)username;

-(DesireEntity*)newDesire:(NSString *)username;


@end
