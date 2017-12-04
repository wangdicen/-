//
//  MineViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MineViewController.h"
#import "MyInfoView.h"
#import "Header.h"
#import "ThemeViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_datasource;
}
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + SCREEN_HEIGHT/5.0 + 2.0f, SCREEN_WEIGHT, SCREEN_HEIGHT - view.frame.size.height - 4.0f - 20 - self.navigationController.navigationBar.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;

    
    _datasource = [[NSMutableArray alloc] initWithArray:@[@"主题",@"喜欢",@"小组",@"设置",@"消息",@"反馈"]];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: @"cell"];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = IMAGE(@"setting_theme");
            cell.textLabel.text = @"主题";
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.imageView.image = IMAGE(@"setting_like");
            cell.textLabel.text = @"喜欢";
        }
        else if(indexPath.row == 1)
        {
            cell.imageView.image = IMAGE(@"setting_group");
            cell.textLabel.text = @"小组";
        }
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            cell.imageView.image = IMAGE(@"setting_setting");
            cell.textLabel.text = @"设置";
        }
        else if(indexPath.row == 1)
        {
            cell.imageView.image = IMAGE(@"setting_attention");
            cell.textLabel.text = @"消息";
        }
        else if(indexPath.row == 2)
        {
            cell.imageView.image = IMAGE(@"setting_review");
            cell.textLabel.text = @"反馈";
        }
    }
    
    

    
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
