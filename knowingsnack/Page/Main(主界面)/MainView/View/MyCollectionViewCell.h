//
//  MyCollectionViewCell.h
//  knowingsnack
//
//  Created by travelsky on 2018/2/28.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface MyCollectionViewCell : UICollectionViewCell<CWStarRateViewDelegate>

@property (strong, nonatomic) UILabel *botlabel;

@property (strong, nonatomic) UIImageView *topImage;


@property (strong, nonatomic) CWStarRateView *starview;

@property (strong, nonatomic) UILabel *starNum;

@property (assign, nonatomic) NSString *objectID;


@end
