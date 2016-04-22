//
//  FBScreenXQTableViewCell.m
//  FirstBlood
//
//  Created by lanou on 16/4/22.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBScreenXQTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation FBScreenXQTableViewCell



-(void)getDataModel:(FBScreenXQModel *)model
{
    _theme.text = model.theme;
        NSString * strr = [NSString stringWithFormat:@"%@/",model.nowPrice];
        _nowPrice.text =strr;
 
    NSString *str1 = [NSString stringWithFormat:@"%@",model.consumerCount];
    
    _consumer.text = [NSString stringWithFormat:@"%@%@",str1,model.consumerUnit];
    _orgPrice.text =[NSString stringWithFormat:@"%@",model.orgPrice];
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
