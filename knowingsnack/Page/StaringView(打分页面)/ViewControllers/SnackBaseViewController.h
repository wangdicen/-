//
//  SnackBaseViewController.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger viewcontroller_type;

@interface SnackBaseViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
