//
//  MineViewController.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MineViewController.h"
#import "MyInfoView.h"
#import "Header.h"
#import "ThemeViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addUI];
}

- (void)addUI{
    MyInfoView *view = [[MyInfoView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20.0f +2.0f, SCREEN_WEIGHT, SCREEN_HEIGHT/5.0)];
    [self.view addSubview:view];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + SCREEN_HEIGHT/5.0 + 2.0f, SCREEN_WEIGHT, SCREEN_HEIGHT - view.frame.size.height - 4.0f - 20 - self.navigationController.navigationBar.frame.size.height)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: @"cell"];
    }
    
//    [cell.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//        UIView *subView = (UIView *)obj;
//        [subView removeFromSuperview];
//    }];
    cell.imageView.image = IMAGE(@"red_spot");
    cell.textLabel.text = @"主题";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self setHidesBottomBarWhenPushed:YES];
        //去设置主题;
        ThemeViewController *tvc = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:tvc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
