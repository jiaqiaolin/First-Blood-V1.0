//
//  FBTableViewCell.h
//  FirstBlood
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 林佳乔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFoodPrivateModel.h"
#import "FBPlayPrivateModel.h"

@interface FBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theme;
@property (weak, nonatomic) IBOutlet UILabel *descrip;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;

@property (weak, nonatomic) IBOutlet UILabel *consumer;

@property (weak, nonatomic) IBOutlet UILabel *orgPrice;


-(void)getDataModel:(FBFoodPrivateModel *)model;

-(void)getDataModel1:(FBPlayPrivateModel *)model;

@end
