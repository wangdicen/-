//
//  RankView.h
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnackBaseViewController.h"

@interface RankView : UIView

@property (nonatomic, assign) SnackViewControllerName viewcontrollertype;

- (instancetype)initWithFrame:(CGRect)frame viewControllerType:(SnackViewControllerName)type;

@end
