//
//  ProfileEntity.h
//  uih
//
//  Created by xing on 13-7-14.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <Foundation/Foundation.h>

//个人资料
@interface ProfileEntity : NSObject
@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * RealName;
@property (nonatomic, retain) NSString * PetName;
@property (nonatomic, retain) NSString * Birthday;
@property (nonatomic, retain) NSString * Sexual;
@property (nonatomic, retain) NSString * BloodType;
@property (nonatomic, retain) NSString * Telphone;
@property (nonatomic, retain) NSString * Address;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * HomeTel;
@property (nonatomic, retain) NSString * PortraitPath;
@property (nonatomic, retain) NSString * PersonCode;
@property (nonatomic, retain) NSString * JoinDate;
@property (nonatomic, retain) NSString * UserDescribe;
@end
