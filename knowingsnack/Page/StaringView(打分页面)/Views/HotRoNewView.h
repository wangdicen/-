//
//  HotRoNewView.h
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/11/1.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SnackBaseViewController.h"

typedef NS_ENUM(NSInteger, HotRoNewType) {
    Hot,
    New
};


@interface HotRoNewView : UIView

@property (nonatomic,assign) HotRoNewType type;

@property (nonatomic, assign) SnackViewControllerName viewcontrollertype;

-(void)fetchDataInBackground;

@end
