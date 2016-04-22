//
//  FBAllDishesSortView.h
//  FirstBlood
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickBlock)(NSInteger tags);

@class FBDishesSortView;

@interface FBAllDishesSortView : UIView


@property (nonatomic, copy) clickBlock block;
@property (nonatomic, retain) FBDishesSortView *view;


-(instancetype)initWithFrame:(CGRect)frame returnTagsBlock:(clickBlock)block;


@end
