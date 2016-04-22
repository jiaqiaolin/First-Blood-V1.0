//
//  FBDishesSortView.m
//  FirstBlood
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBDishesSortView.h"

@implementation FBDishesSortView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dishBtn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _dishBtn.layer.cornerRadius = frame.size.width / 2;
        _dishBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _dishBtn.layer.masksToBounds = YES;
        _dishBtn.layer.borderWidth = 1;
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width / 6, frame.size.width / 6, frame.size.width / 1.5, frame.size.width / 1.5)];
        [_img setImage:[UIImage imageNamed:@"tianpin.png"]];
        [_dishBtn addSubview:_img];
        [self addSubview:_dishBtn];
        
        
        _dishSortLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _dishBtn.frame.size.height + 5, _dishBtn.frame.size.width, frame.size.height * 0.25)];
        [_dishSortLabel setFont:[UIFont systemFontOfSize:12]];
        [_dishSortLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_dishSortLabel];
        
    }
    return self;
}

@end
