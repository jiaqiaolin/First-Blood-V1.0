//
//  FBSeekRestaurantModel.m
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBSeekRestaurantModel.h"

@implementation FBSeekRestaurantModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"imgs"]) {
        NSString* str = value;
        _imgArray = [str componentsSeparatedByString:@","];
    }
    else if([key isEqualToString:@"brightPoints"])
    {
        NSString* str = value;
        _brightPointsArray = [str componentsSeparatedByString:@"_|_"];
    }
    else if([key isEqualToString:@"tags"])
    {
        NSString* str = value;
        _tagsArray = [str componentsSeparatedByString:@","];
    }
    else
    {
        [super setValue:value forKey:key];
    }
}


@end
