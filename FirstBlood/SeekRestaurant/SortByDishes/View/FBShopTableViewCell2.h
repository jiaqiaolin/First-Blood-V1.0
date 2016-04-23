//
//  ShopTableViewCell.h
//  TeamProject
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 Lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBShopTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dishesType;

@property (weak, nonatomic) IBOutlet UILabel *avgPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImgView;

@end
