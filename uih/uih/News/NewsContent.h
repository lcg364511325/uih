//
//  NewsContent.h
//  uih
//
//  Created by 才国 on 13-7-11.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"
#import "NewsEntity.h"

@interface NewsContent : UIViewController{

}

@property(retain , nonatomic) NSString * newid;

@property (nonatomic , strong) IBOutlet UILabel * newsTitle;
@property (nonatomic , strong) IBOutlet UILabel * newsTime;
@property (nonatomic , strong) IBOutlet UITextView * newsContent;

@end
