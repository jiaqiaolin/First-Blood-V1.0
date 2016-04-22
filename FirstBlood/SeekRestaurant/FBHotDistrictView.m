//
//  FBHotDistrictView.m
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBHotDistrictView.h"

@implementation FBHotDistrictView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSInteger tags = 0;
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, FB_SCREEN_WIDTH / 4, 20)];
        [_titleLabel setText:@"热门商圈"];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [self addSubview:_titleLabel];
        for (NSInteger i = 0; i < 3; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                _districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [_districtBtn setBackgroundColor:[UIColor blueColor]];
                [_districtBtn setFrame:CGRectMake(15 + FB_SCREEN_WIDTH / 3.7 * j + FB_SCREEN_WIDTH / 22*j , _titleLabel.frame.origin.y + 30 + i * FB_SCREEN_HEIGHT / 8, FB_SCREEN_WIDTH / 3.6, FB_SCREEN_HEIGHT / 10)];
                [_districtBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"SeekRestaurant%ld.png",tags++]] forState:UIControlStateNormal];
                [_districtBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:5]];
                [self addSubview:_districtBtn];
            }
        }
        
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(15, frame.size.height, FB_SCREEN_WIDTH - 30, 1)];
        [view setBackgroundColor:[UIColor grayColor]];
        [self addSubview:view];
        
    }
    
    return self;
}



@end
