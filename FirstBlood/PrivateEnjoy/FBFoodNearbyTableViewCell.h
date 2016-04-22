//
//  FBFoodNearbyTableViewCell.h
//  FirstBlood
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBNearbyModel.h"

@interface FBFoodNearbyTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *ImgURL;

@property (weak, nonatomic) IBOutlet UILabel *orgPrice;

@property (weak, nonatomic) IBOutlet UILabel *theme;

@property (weak, nonatomic) IBOutlet UILabel *nowPrice;

@property (weak, nonatomic) IBOutlet UILabel *consumer;

@property (weak, nonatomic) IBOutlet UILabel *distance;


-(void)getDataModel:(FBNearbyModel *)model;

@end
