//
//  NetWorkRequestManager.m
//  Leisure
//
//  Created by yanlei wu on 16/3/30.
//  Copyright © 2016年 willchao. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager


+(void)requestWithType:(RequewtType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(requestFinish)finish error:(requestError)error
{
    NetWorkRequestManager *manager = [[NetWorkRequestManager alloc]init];
    [manager requestWithType:type urlString:urlString parDic:parDic finish:finish error:error];
    
}
-(void)requestWithType:(RequewtType)type urlString :(NSString *)urlString parDic:(NSDictionary *)pardic finish:(requestFinish)finish error:(requestError)Error
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    //创建可变的urlReuest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if(type == POST)
    {
        //设置请求类型
        [request setHTTPMethod:@"POST"];
        if (pardic.count >0) {
            NSData *data = [self parDicToDataEithDic:pardic];
            //设置请求的body体
            [request setHTTPBody:data];
        }
    
    }
    NSURLSession *seeion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask  = [seeion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(data);
            });
        }else
        {
            Error(error);
        }
    }];
    [dataTask resume];
}

-(NSData *)parDicToDataEithDic:(NSDictionary *)dic
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [array addObject:str];
    }
    
    //将所有参数用&拼接
    NSString *string = [array componentsJoinedByString:@"&"];
    return [string dataUsingEncoding:NSUTF8StringEncoding];
    
}



@end
