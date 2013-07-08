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
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data.");
        /* Json转数组/字典 */
        error = nil;
        //转换方法
        id jsonObject = [NSJSONSerialization
                         JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments
                         error:&error];
        
        if (jsonObject != nil && error == nil){
            NSLog(@"Successfully deserialized...");
            //如果jsonObject是字典类
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                NSLog(@"Dersialized JSON Dictionary = %@", deserializedDictionary);
                return deserializedDictionary;
            }
            //如果jsonObject是数组类
            else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray *deserializedArray = (NSArray *)jsonObject;
                NSLog(@"Dersialized JSON Array = %@", deserializedArray);
                
                return deserializedArray;
            } else {
                NSLog(@"I can't deal with it");
            }
        }
        else if (error != nil){
            NSLog(@"An error happened while deserializing the JSON data."); }
    }
    else if ([jsonData length] == 0 &&error == nil){
        NSLog(@"No data was returned after serialization.");
    }
    else if (error != nil){
        NSLog(@"An error happened = %@", error);
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

/*
- (IBAction)btnPressIOS5Json:(id)sender {
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101180601.html"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    
    txtView.text = [NSString stringWithFormat:@"今天是 %@  %@  %@  的天气状况是：%@  %@ ",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"], [weatherInfo objectForKey:@"weather1"], [weatherInfo objectForKey:@"temp1"]];
    
    NSLog(@"weatherInfo字典里面的内容为--》%@", weatherDic );
}
*/
@end
