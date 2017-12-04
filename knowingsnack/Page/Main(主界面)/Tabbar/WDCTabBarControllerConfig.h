//
//  WDCTabBarControllerConfig.h
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/23.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDCTabBarController.h"

@interface WDCTabBarControllerConfig : NSObject

@property (nonatomic, readonly, strong) WDCTabBarController *tabBarController;

- (void)setColorWithColor:(UIColor *)color;
@end
