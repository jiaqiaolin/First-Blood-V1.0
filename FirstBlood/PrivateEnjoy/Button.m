//
//  Button.m
//  GoodThing
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 冯乐. All rights reserved.
//

#import "Button.h"
#import <Masonry.h>
//#import "Masonry.h"
@interface Button ()
@property (nonatomic,retain)UIView *ButtonView;
@property (nonatomic,retain)UIButton *NewestButton;
@end
@implementation Button

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _NewestButton = [Button buttonWithType:UIButtonTypeCustom];
//        [_NewestButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3, 0, 60, 45)];
//        [_NewestButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_NewestButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [self addSubview:_NewestButton];
//        
//    }
//    return self;
//}


-(UIView *)ButtonView{
    if (!_ButtonView) {
        _ButtonView = [[UIView alloc]initWithFrame:CGRectZero];
        _ButtonView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_ButtonView];
        [_ButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-1);
        }];
    }
    return _ButtonView;
}

-(void)setStatus:(BOOL)select{
    self.selected = select;
    self.ButtonView.hidden = !select;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
