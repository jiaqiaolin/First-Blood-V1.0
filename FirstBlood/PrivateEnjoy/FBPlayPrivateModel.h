//
//  FBPlayPrivateModel.h
//  FirstBlood
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBPlayPrivateModel : NSObject

@property (nonatomic,retain) NSString *theme;
@property (nonatomic,retain) NSString *imgURL;
@property (nonatomic,retain) NSString *nowPrice;
@property (nonatomic,retain) NSString *descrip;
@property (nonatomic,retain) NSString *consumerUnit;
@property (nonatomic,retain) NSString *consumerCount;
@property (nonatomic,retain) NSString *orgPrice;
@property (nonatomic,retain) NSString *masterID;


-(instancetype)initWithInfoDic:(NSDictionary *)dic;
@end
