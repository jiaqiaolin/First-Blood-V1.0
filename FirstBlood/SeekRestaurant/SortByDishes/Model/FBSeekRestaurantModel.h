//
//  FBSeekRestaurantModel.h
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBSeekRestaurantModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *areaName;
@property (nonatomic, copy)NSString *brightPoints;
@property (nonatomic, copy)NSString *imgs;
@property (nonatomic, copy)NSString *logo;
@property (nonatomic, copy)NSString *tags;
@property (nonatomic, assign)NSInteger avgPrice;
@property (nonatomic, assign)NSInteger haveGoods;

//@property (nonatomic, copy)NSString* listID;

@property (nonatomic, copy)NSArray *imgArray;
@property (nonatomic, copy)NSArray *brightPointsArray;
@property (nonatomic, copy)NSArray *tagsArray;
@end
