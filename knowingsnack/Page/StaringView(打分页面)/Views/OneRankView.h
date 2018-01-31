//
//  OneRankView.h
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneRankView : UIView

@property (nonatomic,copy) UIImage *image;

@property (nonatomic,assign) NSString *title;

@property (nonatomic,assign) NSInteger rankNum;

@property (nonatomic,assign) CGFloat starfloatNum;

@property (nonatomic,strong) NSString *objectID;

@property (nonatomic,assign) CGFloat numOfCommentPeople;

@end
