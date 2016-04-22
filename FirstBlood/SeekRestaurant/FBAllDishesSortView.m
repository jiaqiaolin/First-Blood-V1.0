//
//  FBAllDishesSortView.m
//  FirstBlood
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import "FBAllDishesSortView.h"
#import "FBDishesSortView.h"

@implementation FBAllDishesSortView

-(instancetype)initWithFrame:(CGRect)frame returnTagsBlock:(clickBlock)block
{
    self = [super initWithFrame:frame];
    NSArray* array = @[@"西餐",@"日料",@"甜品",@"中国菜",@"火锅",@"自助餐",@"酒吧",@"咖啡"];
    NSInteger tags = 3001;
    if (self) {
        for (NSInteger i = 0; i < 2; i++) {
            for (NSInteger j = 0; j < 4; j++) {
                _view = [[FBDishesSortView alloc]initWithFrame:CGRectMake(j * FB_SCREEN_WIDTH / 9 + FB_SCREEN_WIDTH / 9.5 + FB_SCREEN_WIDTH / 9*j, i * FB_SCREEN_HEIGHT / 8 + 15 , FB_SCREEN_WIDTH / 8, FB_SCREEN_HEIGHT / 10)];
                [_view.dishSortLabel setText:array[tags - 3001]];
                [_view.img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"SeekRestaurant%ld.png",tags]]];
                [_view.dishBtn setTag:tags];
                [_view.dishBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_view];
                tags++;
            }
        }
        
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(15, frame.size.height, FB_SCREEN_WIDTH - 30, 1)];
        [view setBackgroundColor:[UIColor grayColor]];
        [self addSubview:view];
        self.block = block;
    }
    
    return self;
}


-(void)click:(UIButton*)sender
{
    self.block(sender.tag);
}


@end
