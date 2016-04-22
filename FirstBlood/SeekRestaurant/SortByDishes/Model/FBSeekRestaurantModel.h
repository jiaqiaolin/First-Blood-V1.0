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
@property (nonatomic, assign)NSInteger avgPrice;
@property (nonatomic, copy)NSString* listID;


@end
