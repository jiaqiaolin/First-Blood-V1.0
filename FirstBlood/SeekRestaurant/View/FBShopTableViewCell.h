//
//  ShopTableViewCell.h
//  TeamProject
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 Lzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBrightPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *secBrightPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdBrightPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishesType;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel1;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel2;
@property (weak, nonatomic) IBOutlet UILabel *dotLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *vipImgView;

@end
