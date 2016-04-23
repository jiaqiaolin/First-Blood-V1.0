//
//  FBHotDistrictView.h
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickBlock)(NSInteger tags);
@interface FBHotDistrictView : UIView

@property (nonatomic, copy) clickBlock block;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *districtBtn;

-(instancetype)initWithFrame:(CGRect)frame returnTagsBlock:(clickBlock)block;

@end
