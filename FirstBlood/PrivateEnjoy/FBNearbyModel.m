//
//  FBNearbyModel.m
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBNearbyModel.h"

@implementation FBNearbyModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        self.masterID = value;
    }else {
        [super setValue:value forKey:key];
    }
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}
@end
