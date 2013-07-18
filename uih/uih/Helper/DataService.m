//
//  DataService.m
//  uih
//
//  Created by 陈 星 on 13-6-30.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "DataService.h"

@implementation DataService


-(NSMutableArray*)GetNews_yejhd:(int)Page typeid:(int)typeid
{
    NSMutableArray * m = [[NSMutableArray alloc] initWithCapacity:20];
    
    NSString *urlps=api_news_yejhd;
    
    if (typeid==1) {
        urlps=api_news_jyxxx;
    }else if (typeid==2){
        urlps=api_news_tsjx;
    }else if (typeid==4){
        urlps=api_news_yehwj;
    }else if (typeid==5){
        urlps=api_news_yejhd;
    }
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,urlps];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:Page forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;

        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                //NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                //单个对象
            }
            else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray * objArray = (NSArray *)jsonObject;

                for(int i = 0 ; i < objArray.count ; i++)
                {
                    NSDictionary * d = (NSDictionary *)objArray[i];
          
                    NewsEntity * n = [[NewsEntity alloc] init];
                    n.peta_rn = [d objectForKey:@"peta_rn"];
                    n.ID = [d objectForKey:@"ID"];
                    n.ArticleTitle = [d objectForKey:@"ArticleTitle"];
                    n.ArticleType = [d objectForKey:@"ArticleType"];
                    n.OperatorDate = [d objectForKey:@"OperatorDate"];
                    
                    [m addObject:n];
                }
                 
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

    return m;
}

-(NewsEntity *)GetNews_content:(NSString *)newid
{
    
    NSString * surl = [NSString stringWithFormat:@"%@&ID=%@",api_news_content,newid];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,surl];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                //单个对象
                NewsEntity * n = [[NewsEntity alloc] init];
                n.peta_rn = [d objectForKey:@"peta_rn"];
                n.ID = [d objectForKey:@"ID"];
                n.ArticleTitle = [d objectForKey:@"ArticleTitle"];
                n.ArticleType = [d objectForKey:@"ArticleType"];
                n.OperatorDate = [d objectForKey:@"OperatorDate"];
                
                n.ArticleContent = [d objectForKey:@"ArticleContent"];
                n.ReadCount = [d objectForKey:@"ReadCount"];
                n.IsHot = [d objectForKey:@"IsHot"];
                
                return n;
            }
            else {
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

//登录接口
-(LoginEntity *)login:(NSString *)username password:(NSString *)password verlity:(NSString*)verlity
{
    
    NSString * surl = [NSString stringWithFormat:@"Application/checkLogin.ashx?Action=checklogin&UserName=%@&UserPWD=%@&Lcode=%@",username,password,verlity];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,surl];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                //单个对象
                LoginEntity * n = [[LoginEntity alloc] init];
                n.result = [[d objectForKey:@"result"] stringValue];
                n.info = [d objectForKey:@"info"];
                n.webcode = [d objectForKey:@"webcode"];
                
                return n;
            }
            else {
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

//查询个人资料
-(ProfileEntity *)schoolPersonnel:(NSString *)username
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * surl = [NSString stringWithFormat:@"Application/myInformation.ashx?Action=schoolPersonnel&UserName=%@&webcode=%@",username,myDelegate.webcode];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,surl];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *dd = (NSDictionary *)jsonObject;
                
                NSDictionary *d = (NSDictionary *)[dd objectForKey:@"userInfo"];
                
                //单个对象
                ProfileEntity * n = [[ProfileEntity alloc] init];
                n.ID = [d objectForKey:@"ID"];
                n.RealName = [d objectForKey:@"RealName"];
                n.PetName = [d objectForKey:@"PetName"];
                n.Birthday = [d objectForKey:@"Birthday"];
                
                n.Sexual = [d objectForKey:@"Sexual"];
                n.BloodType = [d objectForKey:@"BloodType"];
                n.Telphone = [d objectForKey:@"Telphone"];
                
                n.Address = [d objectForKey:@"Address"];
                n.Email = [d objectForKey:@"Email"];
                n.HomeTel = [d objectForKey:@"HomeTel"];
                n.PortraitPath = [d objectForKey:@"PortraitPath"];
                n.PersonCode = [d objectForKey:@"PersonCode"];
                n.JoinDate = [d objectForKey:@"JoinDate"];
                n.UserDescribe = [d objectForKey:@"UserDescribe"];
                n.Constellation = [d objectForKey:@"Constellation"];
                
                n.contactInfo = [dd objectForKey:@"contactInfo"];
                
                return n;
            }
            else {
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


//查询个人资料
-(DesireEntity *)newDesire:(NSString *)username
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString * surl = [NSString stringWithFormat:@"Application/myDesire.ashx?Action=newDesire&UserName=%@&webcode=%@",username,myDelegate.webcode];
    
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",domain,surl];
    
    NSMutableDictionary * dict = [self GetDataService:URL forPage:1 forPageSize:[PSize intValue]];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        error = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (jsonObject != nil && error == nil){
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                NSDictionary *d = (NSDictionary *)jsonObject;
                //单个对象
                DesireEntity * n = [[DesireEntity alloc] init];
                n.ID = [d objectForKey:@"ID"];
                n.DesireContent = [d objectForKey:@"DesireContent"];
                n.ReleaseDate = [d objectForKey:@"ReleaseDate"];
                n.PraiseNumber = [d objectForKey:@"PraiseNumber"];
                
                return n;
            }
            else {
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




















-(NSMutableDictionary*)GetDataService:(NSString*) URL forPage:(int)Page forPageSize:(int)PageSize
{
    NSError *error;
    
    if([URL rangeOfString:@"?"].length > 0)
        URL = [NSString stringWithFormat:@"%@&page=%d&pagesize=%d",URL,Page,PageSize];
    else
        URL = [NSString stringWithFormat:@"%@?page=%d&pagesize=%d",URL,Page,PageSize];
    
    NSLog(@"%@",URL);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    return dict;
}

@end
