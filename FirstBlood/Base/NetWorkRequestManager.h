//
//  NetWorkRequestManager.h
//  Leisure
//
//  Created by yanlei wu on 16/3/30.
//  Copyright © 2016年 willchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequewtType)
{
    GET,
    POST
    
};
//网络请求完成
typedef void(^requestFinish)(NSData *data);
//网络请求失败
typedef void(^requestError)(NSError *error);
@interface NetWorkRequestManager : NSObject

+(void)requestWithType:(RequewtType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(requestFinish)finish error:(requestError)error;



@end
