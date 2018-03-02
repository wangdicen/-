//
//  MyGroupViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/1.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "MyGroupViewController.h"
#import "JHUD.h"
#import "Header.h"

@interface MyGroupViewController ()
{
    JHUD *_jhud;
}
@end

@implementation MyGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _jhud = [[JHUD alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    _jhud.backgroundColor = ClearColor;
    _jhud.messageLabel.text = @"外测版本'小组'还没来得及做~等待下次更新吧~";
    [_jhud.refreshButton setTitle:@"逛逛其他" forState:UIControlStateNormal];
    _jhud.customImage = [UIImage imageNamed:@"nullData"];
    [_jhud showAtView:self.view hudType:JHUDLoadingTypeFailure];
    
    [_jhud setJHUDReloadButtonClickedBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
