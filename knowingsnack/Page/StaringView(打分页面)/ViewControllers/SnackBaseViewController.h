//
//  SnackBaseViewController.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SnackViewControllerName) {
    NameSnackViewController,
    NameDrinkViewController,
    NameFangBianViewController,
    NameFruitViewController,
    NameSweetViewController,
    NameSpicyViewController,
    NameMeatViewController,
};



extern NSInteger viewcontroller_type;

@interface SnackBaseViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) SnackViewControllerName viewcontrollerName;


@end
