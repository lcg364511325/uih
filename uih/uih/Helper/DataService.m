//
//  DataService.m
//  uih
//
//  Created by 陈 星 on 13-6-30.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "DataService.h"

@implementation DataService

-(id)convseFromJson:(NSMutableDictionary*)dictionary
{
    NSMutableArray * m = [[NSMutableArray alloc] initWithCapacity:20];
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,api_news_yejhd];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:Page forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;

        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                NSLog(@"Dersialized JSON Dictionary = %@", deserializedDictionary);
                return deserializedDictionary;
            }
            else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray *deserializedArray = (NSArray *)jsonObject;
                NSLog(@"Dersialized JSON Array = %@", deserializedArray);
                
                return deserializedArray;
            } else {
                NSLog(@"无法解析的数据结构.");
            }
        }
        else if (error != nil){
            NSLog(@"%@",error);
        }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"空的数据集.");
    }
    else if (error != nil){
        NSLog(@"发生致命错误：%@", error);
    }
    
    return nil;
}

-(NSMutableArray*)GetNews_yejhd
{
    //NSMutableArray * m = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,api_news_yejhd];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:1 forPageSize:PSize];
    
    NSArray *deserializedArray =[self convseFromJson:dict];
    
    //NSLog(@"GetNews_yejhd-----------------%@",deserializedArray);
    
    /*
    //总记录数
    int total = (int)[dict objectForKey:@"total"];
    
    NSDictionary * list = [dict objectForKey:@"data"];
    
    for(int i = 0 ; i < list.count ; i++)
    {
        //NSDictionary *　d = [list]
        //NewsEntity * n = [[NewsEntity alloc] init];
        //n.peta_rn =
    }
    */
    return nil;
}


-(NSMutableDictionary*)GetDataService:(NSString*) URL forPage:(int)Page forPageSize:(int)PageSize
{
    NSError *error;
    
    if([URL rangeOfString:@"?"].length > 0)
        URL = [NSString stringWithFormat:@"%@&page=%d&pagesize=%d",URL,Page,PageSize];
    else
        URL = [NSString stringWithFormat:@"%@?page=%d&pagesize=%d",URL,Page,PageSize];
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    return dict;
}

@end
