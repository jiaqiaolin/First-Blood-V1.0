//
//  FBTopicView.m
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBTopicView.h"


@implementation FBTopicView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, FB_SCREEN_WIDTH / 4, 20)];
        [_titleLabel setText:@"精选专题"];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [self addSubview:_titleLabel];
        
        for (NSInteger i = 0; i < 5; i++) {
            _topicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_topicBtn setFrame:CGRectMake(15, _titleLabel.frame.origin.y + 30 + i * FB_SCREEN_HEIGHT / 5, FB_SCREEN_WIDTH - 30, FB_SCREEN_HEIGHT / 6)];
            
            [self addSubview:_topicBtn];
        }
        
       
    }
    return self;
}




@end
