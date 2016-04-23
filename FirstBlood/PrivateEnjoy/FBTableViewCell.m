//
//  FBTableViewCell.m
//  FirstBlood
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation FBTableViewCell



-(void)getDataModel:(FBFoodPrivateModel *)model
{
    _theme.text = model.theme;
    NSString * strr = [NSString stringWithFormat:@"%@",model.nowPrice];
    _nowPrice.text = strr;
    NSString *str1 = [NSString stringWithFormat:@"%@",model.consumerCount];
    _consumer.text = [NSString stringWithFormat:@"/%@%@",str1,model.consumerUnit];
    _orgPrice.text = [NSString stringWithFormat:@"%@",model.orgPrice];
    _descrip.text = model.descrip;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];

}

-(void)getDataModel1:(FBPlayPrivateModel *)model
{
    _theme.text = model.theme;
    NSLog(@"%@",model.theme);
    NSString * strr = [NSString stringWithFormat:@"%@/",model.nowPrice];
    _nowPrice.text = strr;
    NSString *str1 = [NSString stringWithFormat:@"%@",model.consumerCount];
    _consumer.text = [NSString stringWithFormat:@"%@%@",str1,model.consumerUnit];
    _orgPrice.text = [NSString stringWithFormat:@"%@",model.orgPrice];
    _descrip.text = model.descrip;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
