//
//  NewsEntity.h
//  uih
//
//  Created by 陈 星 on 13-7-1.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <Foundation/Foundation.h>

//未登录发布新闻
@interface NewsEntity : NSObject

@property (nonatomic, retain) NSString * peta_rn;
@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * ArticleType;
@property (nonatomic, retain) NSString * ArticleTitle;
@property (nonatomic, retain) NSString * OperatorDate;

@property (nonatomic, retain) NSString * ArticleContent;
@property (nonatomic, retain) NSString * OperatorName;
@property (nonatomic, retain) NSString * IsHot;
@property (nonatomic, retain) NSString * ReadCount;

@end
