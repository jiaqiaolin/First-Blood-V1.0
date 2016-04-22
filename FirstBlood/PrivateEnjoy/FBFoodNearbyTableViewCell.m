//
//  FBFoodNearbyTableViewCell.m
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBFoodNearbyTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation FBFoodNearbyTableViewCell


-(void)getDataModel:(FBNearbyModel *)model
{
    _theme.text = model.theme;
    NSString * strr = [NSString stringWithFormat:@"%@/",model.nowPrice];
    _nowPrice.text =strr;
    
    NSString *str1 = [NSString stringWithFormat:@"%@",model.consumerCount];
    _consumer.text = [NSString stringWithFormat:@"%@%@",str1,model.consumerUnit];
    _orgPrice.text =[NSString stringWithFormat:@"%@",model.orgPrice];
    [_ImgURL sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];
    
    NSString *string = [NSString stringWithFormat:@"%@",model.distance];
    string = [string substringToIndex:4];
    NSString * string1 = [NSString stringWithFormat:@"%@km",string];
    _distance.text = string1;
    
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
