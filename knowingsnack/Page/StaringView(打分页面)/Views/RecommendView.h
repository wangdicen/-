//
//  RecommendView.h
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/31.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SnackBaseViewController.h"


@interface RecommendView : UIView

@property (nonatomic, assign) SnackViewControllerName type;

-(void)fetchDataInBackground;

@end
